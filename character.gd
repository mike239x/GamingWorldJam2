extends Node2D

@export var speed:float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_down"):
		self.position += Vector2(0,speed)
	if Input.is_action_pressed("move_up"):
		self.position += Vector2(0,-speed)
	if Input.is_action_pressed("move_left"):
		self.position += Vector2(-speed,0)
	if Input.is_action_pressed("move_right"):
		self.position += Vector2(speed,0)

