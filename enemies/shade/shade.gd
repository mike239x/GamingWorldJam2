extends CharacterBody2D

signal death(me)

@onready var hitbox = $Sprite2D/Hitbox
@onready var brain = $Brain

func _ready():
	hitbox.start_with(10)
	$AnimationPlayer.current_animation = 'walk'
	wall_min_slide_angle = PI / 18
	if randf() < FANCY_SKIN_PROB:
		$Sprite2D.texture = fancy_skin

# movement:
#
# select direction - slight diviation of the original, X% to select random
# select how far to go - poisson distr
# go there
# repeat
# if hit an obstacle - turn 180
# if player entered aggro range - X% chance to aggro

var base_speed = 150
var chase_speed = 300

var direction = randf_range(-PI, PI)
var RAND_DIR_PROB = 0.2
var PAUSE_PROB = 0.1
var AGGRO_PROB = 0.7
var MAX_ANGLE_CHANGE = PI / 4

var target = null

var fancy_skin = preload("res://enemies/shade/shade_placeholder_2.png")
var FANCY_SKIN_PROB = 0.2

func random_duration():
	return randf_range(.5,1.5)

func select_new_direction():
	if target != null and randf() <= AGGRO_PROB:
		brain.wait_time = 0.5
		# charge at the player
		direction = get_angle_to(target.global_position)
		velocity = Vector2(1,0).rotated(direction) * chase_speed
	else:
		brain.wait_time = random_duration()
		if randf() > RAND_DIR_PROB:
			direction = randf_range(-PI, PI)
		else:
			direction += randf_range(-MAX_ANGLE_CHANGE,MAX_ANGLE_CHANGE)
		if randf() > PAUSE_PROB:
			velocity = Vector2(-1,0).rotated(direction) * base_speed
		else:
			brain.wait_time = 0.25
			velocity = Vector2.ZERO

func _on_brain_timeout():
	select_new_direction()

func _process(delta):
	move_and_slide()

func _on_hitbox_death():
	$AnimationPlayer.play('death')
	brain.stop()
	velocity = Vector2.ZERO
	death.emit(self)

func _on_animation_finished(animation):
	if animation == 'death':
		queue_free()

func _on_detection_zone_body_entered(body):
	target = body

func _on_detection_zone_body_exited(body):
	target = null

func _on_close_range_detection_zone_body_entered(body):
	if body == target:
		velocity = Vector2.ZERO
	else:
		velocity *= -1
