extends Area2D

@export var speed = 500
@export var expiration_time = 1
@export var damage = 1
var velocity = Vector2.RIGHT

signal bullet_timeout(bullet)
signal enemy_hit(bullet, enemy)
signal wall_hit(bullet, wall)

func _ready():
	$Timer.start(expiration_time)

func _physics_process(delta):
	position += velocity * speed * delta

func _on_body_entered(body):
	if body.name == "Hitbox":
		enemy_hit.emit(self, body)
		body.take_damage(damage, velocity * speed, global_position)
	queue_free()

func _on_timer_timeout():
	$Timer.stop()
	bullet_timeout.emit(self)
	queue_free()
