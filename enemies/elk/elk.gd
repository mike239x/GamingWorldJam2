extends CharacterBody2D

@onready var hitbox = $Hitbox

@export var speed_factor:float
@export var Tentacle:PackedScene
var average_velocity = Vector2.ZERO

signal new_tentacle(T, pos, dir)

func _ready():
	hitbox.start_with(100)
	wall_min_slide_angle = PI / 2.1

func _process(delta):
	velocity = average_velocity * speed_factor
	move_and_slide()

# movement:
# three actions: idle/jump/attack
# if nothing - idle
#    chance to jump
# if MC in range - attack
#    chance to jump
#    chance to switch attack pattern
# if MC in close_range - jump
var JUMP_PROB = 0.2
var SWITCH_PROB = 0.3

enum MIND_STATE {WANDER, ATTACK, FLEE}
var mind_state = MIND_STATE.WANDER

func idle():
	$AnimationPlayer.play('idle')

func random_jump():
	var direction = randf_range(-PI, PI)
	var distance = randf_range(300, 350)
	jump(direction, distance)

func jump(direction, distance):
	$AnimationPlayer.play('jump')
	average_velocity = Vector2(1,0).rotated(direction) * distance

func attack():
	$AnimationPlayer.play('attack')
	for spot in $AttackSpots.get_children():
		new_tentacle.emit(Tentacle, spot.global_position, spot.global_rotation)

func switch_attack_pattern():
	$AttackSpots.rotation = randf_range(-PI, PI)

func _on_animation_finished(animation):
	# behavior logic
	if mind_state == MIND_STATE.FLEE:
		if randf() < JUMP_PROB:
			idle()
		else:
			random_jump()
	elif mind_state == MIND_STATE.WANDER:
		if randf() < JUMP_PROB:
			random_jump()
		else:
			idle()
	elif mind_state == MIND_STATE.ATTACK:
		if randf() < JUMP_PROB:
			random_jump()
		else:
			if randf() < SWITCH_PROB:
				switch_attack_pattern()
			attack()

func _on_detection_area_body_entered(body):
	mind_state = MIND_STATE.ATTACK

func _on_detection_area_body_exited(body):
	mind_state = MIND_STATE.WANDER

func _on_close_range_body_entered(body):
	mind_state = MIND_STATE.FLEE

func _on_close_range_body_exited(body):
	mind_state = MIND_STATE.ATTACK
