extends GPUParticles2D

@export var speed: float = 100:
	set(value):
		speed = value
		var c = 1/4
		process_material.directional_velocity_max = value * 0.8 * c
		process_material.directional_velocity_min = value * 1.2 * c
	get:
		return speed

func _ready():
	emitting = false
	one_shot = true

func start():
	emitting = true
	$Timer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
