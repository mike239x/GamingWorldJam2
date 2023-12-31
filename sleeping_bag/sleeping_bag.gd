extends Node2D

signal sleep()

@export var interactive: bool = true

func _ready():
	$Hint.visible = false

func _process(delta):
	if Input.is_action_just_released("interact"):
		if $Hint.visible:
			sleep.emit()

func _on_area_2d_body_entered(body):
	if interactive:
		$Hint.visible = true

func _on_area_2d_body_exited(body):
	if interactive:
		$Hint.visible = false
