extends Node2D

#signal target_in_range(target)
var damage = 1
var locked_on = false

func _on_damage_area_body_entered(body):
	var to_body:Vector2 = global_position - body.global_position
	var impact_vector = to_body.normalized() * 300
	#backswing until .24, forth-swing until .6
	if $AnimationPlayer.current_animation_position / $AnimationPlayer.current_animation_length < .25 / .6:
		impact_vector = impact_vector.rotated(PI / 3)
	else:
		impact_vector = impact_vector.rotated(-PI / 3)
	body.take_damage(damage, impact_vector)

func _on_detection_area_body_entered(body):
	if not locked_on:
		locked_on = true
		look_at(body.global_position)
		$AnimationPlayer.play('emerge')
		$AnimationPlayer.queue('attack')
		#target_in_range.emit(body)

func _on_animation_finished(animation):
	if animation == 'attack':
		$AnimationPlayer.play('hide')
	if animation == 'hide':
		locked_on = false
		$AnimationPlayer.play('scan')
