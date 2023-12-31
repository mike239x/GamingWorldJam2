extends Node2D

enum WORLD_STATE {REAL, DREAM}
var state = WORLD_STATE.REAL

signal sleep()

@onready var dream_world = $DreamForest
@onready var real_world = $Forest

func _ready():
	deactivate(dream_world)
	dream_world.hide()
	state = WORLD_STATE.REAL

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
	if state == WORLD_STATE.REAL:
		var c = real_world.day_cycle
		var h = c.current_animation_position
		var h_max = c.current_animation_length
		var s = 0.25
		var h_prime = (1 - h / h_max) * (h_max - h) * s
		c.speed_scale = h_prime
	#if Input.is_action_just_released("tilda"):
		#if  state == WORLD_STATE.DREAM:
			#state = WORLD_STATE.REAL
			#change_world(dream_world, real_world)

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
	if state == WORLD_STATE.REAL:
		state = WORLD_STATE.DREAM
		change_world(real_world, dream_world)
		dream_world.start()

func _on_dream_forest_cleared():
	print('you win!')

func _on_character_death(me):
	print('you lose!')
