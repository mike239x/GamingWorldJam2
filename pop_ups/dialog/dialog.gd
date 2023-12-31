extends "res://pop_ups/generic_popup.gd"

@export var text:String:
	set(value):
		$ColorRect/Label.text = value
	get:
		return $ColorRect/Label.text
