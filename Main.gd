extends Node2D

enum WORLD_STATE {REAL, DREAM}
var state = WORLD_STATE.REAL

# Called when the node enters the scene tree for the first time.
func _ready():
	deactivate($DreamWorld)
	$DreamWorld.hide()
	state = WORLD_STATE.REAL

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

func change_scene(from, to):
	#TODO change to remove_child($Scene) / add_child(scene)
	deactivate(from)
	deactivate($Character)
	$SceneTransition/AnimationPlayer.play('fade_in')
	await $SceneTransition/AnimationPlayer.animation_finished
	from.hide()
	to.show()
	$SceneTransition/AnimationPlayer.play_backwards('fade_in')
	await $SceneTransition/AnimationPlayer.animation_finished
	activate(to)
	activate($Character)

func _process(delta):
	if Input.is_action_just_released("tilda"):
		if state == WORLD_STATE.REAL:
			state = WORLD_STATE.DREAM
			change_scene($RealWorld, $DreamWorld)
		elif state == WORLD_STATE.DREAM:
			state = WORLD_STATE.REAL
			change_scene($DreamWorld, $RealWorld)
