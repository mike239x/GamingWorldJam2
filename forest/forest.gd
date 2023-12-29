extends Node2D

signal sleep()

func _on_sleeping_bag_sleep():
	sleep.emit()
