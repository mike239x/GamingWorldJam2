extends CanvasLayer

@export var MC:Node2D = null
@export var time_source:Node2D = null

func _ready():
	pass

func _process(delta):
	if MC != null:
		$Health.max_value = MC.max_health
		$Health.value = MC.health
		$Stamina.max_value = MC.max_stamina
		$Stamina.value = MC.stamina
	if time_source != null:
		var time = time_source.time # time in hours
		var hours = floori(time)
		var minutes = floori((time - hours) * 60)
		$Time.text = '%02d:%02d' % [hours, minutes]
