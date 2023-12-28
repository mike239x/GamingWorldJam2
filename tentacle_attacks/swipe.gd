extends Node2D

signal target_in_range(target)
var damage = 1

func _on_damage_area_body_entered(body):
	var to_body:Vector2 = get_global_position() - body.get_global_position()
	var impact_vector = to_body.normalized() * 300
	#backswing until .24, forth-swing until .6
	if $AnimationPlayer.current_animation_position / $AnimationPlayer.current_animation_length < .25 / .6:
		impact_vector = impact_vector.rotated(PI / 2)
	else:
		impact_vector = impact_vector.rotated(-PI / 2)
	body.take_damage(damage, impact_vector)

func _on_detection_area_body_entered(body):
	target_in_range.emit(body)
