extends CanvasLayer

@export var MC:Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MC != null:
		$Health.max_value = MC.max_health
		$Health.value = MC.health
		$Stamina.max_value = MC.max_stamina
		$Stamina.value = MC.stamina
