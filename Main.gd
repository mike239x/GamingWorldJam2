extends Node2D

enum WORLD_STATE {REAL, DREAM}
var state = WORLD_STATE.REAL

signal sleep()

@onready var deam_world = $DreamForest
@onready var real_world = $Forest

# Called when the node enters the scene tree for the first time.
func _ready():
	deactivate(deam_world)
	deam_world.hide()
	state = WORLD_STATE.REAL
	$DreamForest/Elk.new_tentacle.connect(_new_tentacle)

func _new_tentacle(T:PackedScene, pos, dir):
	var tentacle = T.instantiate()
	add_child(tentacle)
	tentacle.global_position = pos
	tentacle.direction = dir
	tentacle.new_spike.connect(_new_spike)

func _new_spike(T:PackedScene, pos):
	var spike = T.instantiate()
	add_child(spike)
	spike.global_position = pos

#TODO maybe introduce the state - dream/reality, day/night, location?

func deactivate(node):
	node.set_process(false)
	node.set_physics_process(false)
	node.set_process_unhandled_input(false)
	node.set_process_input(false)

func activate(node):
	node.set_process(true)
	node.set_physics_process(true)
	node.set_process_unhandled_input(true)
	node.set_process_input(true)

func change_world(from, to):
	#TODO change to remove_child($Scene) / add_child(scene)
	deactivate(from)
	deactivate($Character)
	$SceneTransition/AnimationPlayer.play('fade_in')
	await $SceneTransition/AnimationPlayer.animation_finished
	from.hide()
	$HUD.time_source = to
	to.show()
	$SceneTransition/AnimationPlayer.play_backwards('fade_in')
	await $SceneTransition/AnimationPlayer.animation_finished
	activate(to)
	activate($Character)

func _process(delta):
	if Input.is_action_just_released("tilda"):
		if  state == WORLD_STATE.DREAM:
			state = WORLD_STATE.REAL
			change_world(deam_world, real_world)

func _on_gun_shoot(Bullet, direction, location):
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.rotation = direction
	bullet.position = location
	bullet.velocity = bullet.velocity.rotated(direction)
	bullet.bullet_timeout.connect(_on_bullet_timeout)

func _on_new_spike(Spike, pos):
	var spike = Spike.instantiate()
	add_child(spike)
	spike.global_position = global_position

func _on_bullet_timeout(bullet):
	pass

#signal bullet_timeout(bullet)
#signal enemy_hit(bullet, enemy)
#signal wall_hit(bullet, wall)


func _on_real_world_sleep():
	print('nighty night')
	if state == WORLD_STATE.REAL:
		state = WORLD_STATE.DREAM
		change_world(real_world, deam_world)

