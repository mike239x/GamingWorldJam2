extends Node2D

var damage = 3

func _on_damage_area_body_entered(body):
	body.take_damage(damage, Vector2(0,-300))

func _on_animation_finished(animation):
	queue_free()
