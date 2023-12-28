extends CharacterBody2D

signal death(me)

@onready var hitbox = $Sprite2D/Hitbox

func _ready():
	hitbox.start_with(10)
	$AnimationPlayer.current_animation = 'walk'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = Vector2(-1,0)
	velocity = speed.normalized() * 40
	#move_and_slide()

func _on_body_entered_close_range(body):
	if body.name == "Character":
		body.take_damage(15)

func _on_hitbox_death():
	$AnimationPlayer.current_animation = 'death'
	$AnimationPlayer.animation_finished.connect(_on_death)
	death.emit(self)

func _on_death(_death):
	queue_free()
