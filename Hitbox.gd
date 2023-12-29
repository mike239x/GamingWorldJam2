extends CharacterBody2D

signal death()
signal hit(damage, impact_vector)

@export var max_health:float = 100
@export var health:float = 100

var BloodSplatter = preload("res://blood/blood_splatter.tscn")

func start_with(health):
	self.health = health
	max_health = health

func take_damage(damage, impact_vector = null, collision_point = null):
	'''
	damage - damage value
	impact_vector - vector for blood splatter, with length corresponding to speed
	collision_point - global coordinates of collision point
	'''
	if health <= 0:
		return
	health -= damage
	if impact_vector == null:
		impact_vector = Vector2.ZERO
	if collision_point != null:
		collision_point = to_local(collision_point)
	else:
		collision_point = Vector2.ZERO
	collision_point += impact_vector * 0.03
	var blood = BloodSplatter.instantiate()
	add_child(blood)
	blood.position = collision_point
	blood.fire(impact_vector)
	hit.emit(damage, impact_vector)
	if health <= 0:
		health = 0
		death.emit()
