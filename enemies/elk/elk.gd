extends CharacterBody2D

@onready var hitbox = $Hitbox

func _ready():
	hitbox.start_with(100)
