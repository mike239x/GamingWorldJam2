extends CanvasLayer

@export var return_msg = 'done'
signal done(result)

@export var Page1:PackedScene
@export var Page2:PackedScene

func _ready():
	var p1 = Page1.instantiate()
	add_child(p1)
	p1.done.connect(_page_1_cb)

func _page_1_cb(_code):
	var p2 = Page2.instantiate()
	add_child(p2)
	p2.done.connect(_page_2_cb)

func _page_2_cb(_code):
	done.emit(return_msg)
	queue_free()
