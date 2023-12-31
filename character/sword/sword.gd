extends Node2D

var reload_duration = 0.8
var damage = 3
var lmb_held = false

@export var active:bool = false
@export var slashing:bool = false

func _process(delta):
	look_at(get_global_mouse_position())

func fire():
	if not active: return
	$Slash/AnimationPlayer.play('attack')
	$Reload.start(reload_duration)

func _input(event):
	if event is InputEventMouseButton:
		lmb_held = event.pressed
		if $Reload.time_left == 0.0:
			fire()

func _on_reload_timeout():
	if lmb_held:
		fire()

func _on_damage_area_body_entered(body):
	if slashing:
		var impact_vector = (body.global_position - global_position).normalized().rotated(PI/2) * 300;
		body.take_damage(damage, impact_vector)
