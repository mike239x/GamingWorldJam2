extends Node2D

var total_number_of_spikes = 6
var number_of_spikes_left = total_number_of_spikes
var interval_between_spikes = 0.1
var delay_before_start = 0.5

var speed = 300
var direction = 0.0

@export var Spike:PackedScene

signal new_spike(spike, pos)

func _ready():
	if delay_before_start != 0:
		$Timer.start(delay_before_start)
	else:
		_on_timer_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delay_before_start == 0.0:
		position += Vector2(speed*delta,0).rotated(direction)

func _on_timer_timeout():
	delay_before_start = 0.0
	new_spike.emit(Spike, global_position)
	number_of_spikes_left -= 1
	if number_of_spikes_left == 0:
		queue_free()
	else:
		$Timer.start(interval_between_spikes)
