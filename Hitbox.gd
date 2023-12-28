extends CharacterBody2D

signal death()
signal hit(damage, impact_vector)

@export var max_health:float = 100
@export var health:float = 100

var BloodSplatter = preload("res://blood/blood_splatter.tscn")

func start_with(health):
	self.health = health
	max_health = health

func take_damage(damage, impact_vector = null):
	if health <= 0:
		return
	health -= damage
	var blood = BloodSplatter.instantiate()
	add_child(blood)
	blood.fire(impact_vector)
	hit.emit(damage, impact_vector)
	if health <= 0:
		health = 0
		death.emit()
