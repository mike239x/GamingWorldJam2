extends CharacterBody2D

@onready var hitbox = $Sprite2D/Hitbox

func _ready():
	hitbox.start_with(100)
