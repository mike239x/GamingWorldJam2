extends Node2D

enum WORLD_STATE {REAL, DREAM}
var state = WORLD_STATE.REAL

# Called when the node enters the scene tree for the first time.
func _ready():
	deactivate($DreamWorld)
	state = WORLD_STATE.REAL

#TODO maybe introduce the state - dream/reality, day/night, location?

func deactivate(node):
	node.hide()
	node.set_process(false)
	node.set_physics_process(false)
	node.set_process_unhandled_input(false)
	node.set_process_input(false)

func activate(node):
	node.show()
	node.set_process(true)
	node.set_physics_process(true)
	node.set_process_unhandled_input(true)
	node.set_process_input(true)

func _process(delta):
	if Input.is_action_just_released("tilda"):
		if state == WORLD_STATE.REAL:
			state = WORLD_STATE.DREAM
			deactivate($RealWorld)
			activate($DreamWorld)
		elif state == WORLD_STATE.DREAM:
			state = WORLD_STATE.REAL
			deactivate($DreamWorld)
			activate($RealWorld)
