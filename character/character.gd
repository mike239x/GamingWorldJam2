extends CharacterBody2D

# signal forwarding the gun shots from the gun node
signal shoot(Bullet, direction, location)

@export var max_speed:float = 400

@onready var hitbox = $Pivot/Sprite2D/Hitbox

var max_health:float:
	set(value):
		hitbox.max_health = value
	get:
		return hitbox.max_health
var health:float:
	set(value):
		hitbox.health = value
	get:
		return hitbox.health
var max_stamina:float = 100
var stamina:float = max_stamina
var max_sanity:float = 100
var sanity:float = max_stamina


# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.start_with(100)

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
	$AnimationTree.set('parameters/Walk/blend_position', muzzle)

	if speed == Vector2.ZERO:
		$AnimationTree.get('parameters/playback').travel('Idle')
	else:
		$AnimationTree.get('parameters/playback').travel('Walk')
		#$AnimationTree.set('parameters/Walk/blend_position', speed)
		#$AnimationTree.set('parameters/Idle/blend_position', speed)

func _on_gun_shoot(Bullet, direction, location):
	shoot.emit(Bullet, direction, location)
