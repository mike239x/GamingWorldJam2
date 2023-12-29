extends Node2D

#signal target_in_range(target)

var damage = 1
var locked_on = false
var rotation_speed = 3

func _process(delta):
#	print( $AnimationPlayer.is_playing())
	if not locked_on:
		rotation += delta * rotation_speed

func attack():
	$AnimationPlayer.play('emerge')
	$AnimationPlayer.queue('attack')

func _on_animation_finished(animation):
	if animation == 'attack':
		$AnimationPlayer.play('hide')
	if animation == 'hide':
		locked_on = false
		if randi() % 2 == 0:
			rotation_speed *= -1

func _on_damage_area_body_entered(body):
	body.take_damage(damage, Vector2(300,0).rotated(global_rotation))

func _on_detection_area_body_entered(body):
	if not locked_on:
		locked_on = true
		attack()
		#target_in_range.emit(body)
