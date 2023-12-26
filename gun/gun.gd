extends Node2D

signal shoot(Bullet, direction, location)

@export var Bullet: PackedScene = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	#rotate(get_angle_to(Vector2.ZERO))

func _input(event):
	if Input.is_action_just_pressed("LMB"):
		shoot.emit(Bullet, rotation, position)
