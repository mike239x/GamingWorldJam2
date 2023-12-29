extends Node2D

signal shoot(Bullet, direction, location)

@export var Bullet: PackedScene = preload("res://bullet/bullet.tscn")

func _process(delta):
	look_at(get_global_mouse_position())

func _input(event):
	if Input.is_action_just_pressed("LMB"):
		shoot.emit(Bullet, $Muzzle.global_rotation, $Muzzle.global_position)
