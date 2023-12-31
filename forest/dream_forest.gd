extends Node2D

@export var mc:Node2D = null
@export var Elk:PackedScene
@export var Shade:PackedScene

signal new_elk(elkScene, pos)
signal cleared()

var number_of_elks_left = 0
var number_of_elks_killed = 0
var number_of_shades_left = 0
var number_of_shades_killed = 0

var active = false

func get_time_label():
	return 'zzz...'

func start():
	for i in range(4):
		spawn_shade()
	$ShadeSpawner.start()
	active = true

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active: return
	if number_of_shades_killed >= 3 and number_of_elks_killed + number_of_elks_left == 0:
		spawn_elk()
	if number_of_shades_left >= 10 and number_of_elks_killed + number_of_elks_left <= 1:
		spawn_elk()
	check_win_condition()

func check_win_condition():
	if number_of_elks_killed > 0 and number_of_elks_left == 0:
		win()

func win():
	if active:
		cleared.emit()
		active = false

func get_random_spawn(spawns_node:Node2D):
	var spawns = spawns_node.get_children()
	var offscreen_spawns = []
	if mc == null:
		offscreen_spawns = spawns
	else:
		for spawn in spawns:
			if (spawn.global_position - mc.global_position).length() > 400:
				offscreen_spawns.append(spawn)
	offscreen_spawns.size()
	return offscreen_spawns[randi_range(0,offscreen_spawns.size()-1)]

func spawn_generic(spawns_node,packed_scene):
	var spawn = get_random_spawn(spawns_node)
	var thing = packed_scene.instantiate()
	$Chars.add_child(thing)
	thing.global_position = spawn.global_position
	return thing

func spawn_elk():
	var elk = spawn_generic($ElkSpawns, Elk)
	elk.new_tentacle.connect(_new_tentacle)
	elk.death.connect(_on_elk_death)
	number_of_elks_left += 1

func _on_elk_death(elk):
	number_of_elks_left -= 1
	number_of_elks_killed += 1

func spawn_shade():
	var shade = spawn_generic($ShadeSpawns, Shade)
	shade.death.connect(_on_shade_death)
	number_of_shades_left += 1

func _on_shade_death(elk):
	number_of_shades_left -= 1
	number_of_shades_killed += 1

func _new_tentacle(T:PackedScene, pos, dir):
	var tentacle = T.instantiate()
	$Chars.add_child(tentacle)
	tentacle.global_position = pos
	tentacle.direction = dir
	tentacle.new_spike.connect(_new_spike)

func _new_spike(T:PackedScene, pos):
	var spike = T.instantiate()
	$Chars.add_child(spike)
	spike.global_position = pos

func _on_shade_spawner_timeout():
	if active:
		spawn_shade()
