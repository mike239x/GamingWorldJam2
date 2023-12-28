extends Node2D

signal sleep()

func _ready():
	$Hint.visible = false

func _process(delta):
	if Input.is_action_just_released("interact"):
		if $Hint.visible:
			sleep.emit()

func _on_area_2d_body_entered(body):
	$Hint.visible = true

func _on_area_2d_body_exited(body):
	$Hint.visible = false
