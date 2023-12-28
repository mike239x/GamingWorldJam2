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

func fire(impact_vector):
	if impact_vector == null:
		impact_vector = Vector2.ZERO
	speed = impact_vector.length()
	rotation = impact_vector.angle()
	emitting = true
	$Timer.start(1)
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
