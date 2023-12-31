extends CanvasLayer

@export var MC:Node2D = null
@export var time_source:Node2D = null

func _process(delta):
	if MC != null:
		$Health.max_value = MC.max_health
		$Health.value = MC.health
		$Stamina.max_value = MC.max_stamina
		$Stamina.value = MC.stamina
	if time_source != null:
		$Time.text = time_source.get_time_label()
