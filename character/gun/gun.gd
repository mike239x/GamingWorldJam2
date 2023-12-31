extends Node2D

signal shoot(Bullet, direction, location)

@export var Bullet: PackedScene

var reload_duration = 0.2

var lmb_held = false

func _process(delta):
	look_at(get_global_mouse_position())

func fire():
	shoot.emit(Bullet, $Muzzle.global_rotation, $Muzzle.global_position)
	$AnimationPlayer.play('fire')
	$Reload.start(reload_duration)

func _input(event):
	if event is InputEventMouseButton:
		lmb_held = event.pressed
		if $Reload.time_left == 0.0:
			fire()

func _on_reload_timeout():
	if lmb_held:
		fire()
