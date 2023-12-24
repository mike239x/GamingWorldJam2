extends CharacterBody2D

@export var max_speed:float = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var speed = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		speed += Vector2(0,1)
	if Input.is_action_pressed("move_up"):
		speed += Vector2(0,-1)
	if Input.is_action_pressed("move_left"):
		speed += Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		speed += Vector2(1,0)
	velocity = speed.normalized() * max_speed
	# print(velocity)
	move_and_slide()
	
	var muzzle = (get_global_mouse_position() - global_position).normalized()
	$AnimationTree.set('parameters/Idle/blend_position', muzzle)
	$AnimationTree.set('parameters/Idle/blend_position', muzzle)

	if speed == Vector2.ZERO:
		$AnimationTree.get('parameters/playback').travel('Idle')
	else:
		$AnimationTree.get('parameters/playback').travel('Walk')
		#$AnimationTree.set('parameters/Walk/blend_position', speed)
		#$AnimationTree.set('parameters/Idle/blend_position', speed)

