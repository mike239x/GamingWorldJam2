extends Node2D

@export var Gameplay:PackedScene
@export var Credits:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	print(_ready)
	start()

func _process(delta):
	pass

func start():
	var gameplay = Gameplay.instantiate()
	add_child(gameplay)
	gameplay.done.connect(_on_gameplay_done)

func _on_gameplay_done():
	display_pop_up(Credits.instantiate(), _after_credits)

func _after_credits(_r):
	get_tree().paused = false
	start()

func display_pop_up(scene, callback):
	add_child(scene)
	scene.done.connect(callback)
	get_tree().paused = true
