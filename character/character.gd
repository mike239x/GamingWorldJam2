extends CharacterBody2D

# signal forwarding the gun shots from the gun node
signal shoot(Bullet, direction, location)
signal death(me)

@export var max_speed:float = 400

@onready var hitbox = $Pivot/Sprite2D/Hitbox

enum WEAPON {GUN, SWORD}
var weapon = WEAPON.SWORD
@onready var gun = $Pivot/MainHand/Gun
@onready var sword = $Pivot/MainHand/Sword

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
	hitbox.start_with(40)
	select_sword()

func select_sword():
	weapon = WEAPON.SWORD
	gun.visible = false
	gun.active = false
	sword.visible = true
	sword.active = true

func select_gun():
	weapon = WEAPON.GUN
	sword.visible = false
	sword.active = false
	gun.visible = true
	gun.active = true

func swap_weapon():
	if weapon == WEAPON.GUN:
		select_sword()
	elif weapon == WEAPON.SWORD:
		select_gun()

func _physics_process(delta):
	var speed = Vector2.ZERO
	if Input.is_action_just_released("weapon_switch"):
		swap_weapon()
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


func _on_hitbox_death():
	death.emit(self)
