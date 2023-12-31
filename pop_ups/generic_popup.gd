extends CanvasLayer

@export var return_msg = 'done'
signal done(result)

func _process(delta):
	if Input.is_action_just_released("interact"):
		done.emit(return_msg)
		queue_free()
