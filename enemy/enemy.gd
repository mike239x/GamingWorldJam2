extends CharacterBody2D

@export var max_health = 10
var health = max_health

signal death(me)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(damage, source = null):
	health -= damage
	#TODO: fancy particles like blood splatter
	if health <= 0:
		death.emit(self)
		#TODO: queue up death animation, then queue_free
		queue_free()


func _on_body_entered_close_range(body):
	if body.name == "Character":
		body.take_damage(15)
