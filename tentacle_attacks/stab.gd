extends Node2D

signal target_in_range(target)
var damage = 1

func _on_damage_area_body_entered(body):
	body.take_damage(damage, Vector2(300,0).rotated(get_global_rotation()))

func _on_detection_area_body_entered(body):
	target_in_range.emit(body)
