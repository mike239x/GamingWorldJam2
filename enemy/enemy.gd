extends CharacterBody2D

@export var max_health = 10
var health = max_health
var BloodSplatter = preload("res://blood/blood_splatter.tscn")

signal death(me)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.current_animation = 'walk'
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = Vector2(-1,0)
	velocity = speed.normalized() * 40
	#move_and_slide()

func take_damage(damage, source = null):
	if health <= 0:
		return
	health -= damage
	#TODO: fancy particles like blood splatter
	if source != null:
		var blood = BloodSplatter.instantiate()
		blood.rotation = source.get_global_rotation()
		$Blood.add_child(blood)
		blood.speed = source.speed
		blood.start()
	if health <= 0:
		$AnimationPlayer.current_animation = 'death'
		$AnimationPlayer.animation_finished.connect(_on_death)
		death.emit(self)

func _on_death(_death):
	queue_free()

func _on_body_entered_close_range(body):
	if body.name == "Character":
		body.take_damage(15)
