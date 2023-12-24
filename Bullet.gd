extends Area2D

@export var speed = 300
var velocity = Vector2.RIGHT

func _physics_process(delta):
	position += velocity * speed * delta
