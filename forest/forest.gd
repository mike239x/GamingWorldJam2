extends Node2D

signal sleep()

@onready var day_cycle = $Shader/AnimationPlayer
# time in hours, from 0 to 24 - epsilon
var time:float:
	set(value):
		day_cycle.seek(value)
	get:
		return day_cycle.current_animation_position

func get_time_label():
	var t = time
	var hours = floori(t)
	var minutes = floori((t - hours) * 60)
	return '%02d:%02d' % [hours, minutes]

func _ready():
	#var time_speed = 1.0/30.0
	var time_speed = 1.0
	day_cycle.play('day_cycle', -1, time_speed)
	time = 12 + 15 / 60

func _on_sleeping_bag_sleep():
	sleep.emit()

func _process(delta):
	pass

