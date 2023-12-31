class_name Once extends Object

signal trigger()

var triggered = false

func check(cond):
	if triggered: return
	if cond:
		triggered = true
		trigger.emit()

func _init(cb:Callable):
	trigger.connect(cb)
