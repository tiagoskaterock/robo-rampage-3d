extends Node3D

@export var weapon_1 : Node3D
@export var weapon_2 : Node3D

var pre_gun_load = preload("res://FX/gun_load.tscn")

func _ready() -> void:
	equip(weapon_1)

func equip(active_weapon : Node3D) -> void:
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
		else:
			child.visible = false
			child.set_process(false)
	
		
func _unhandled_input(event : InputEvent) -> void:	
	if event.is_action_pressed('next_weapon'):
		next_weapon()
	if event.is_action_pressed("last_weapon"):
		last_weapon()

func gun_load_sfx():
	var gun_load = pre_gun_load.instantiate()
	get_parent().add_child(gun_load)


func next_weapon() -> void:
	var index = get_current_index()
	index = wrapi(index + 1, 0, get_child_count())	
	equip(get_child(index))
	print(index)


func last_weapon() -> void:
	var index = get_current_index()
	index = wrapi(index - 1, 0, get_child_count())	
	equip(get_child(index))
	print(index)
		
	
func get_current_index() -> int:
	for index in get_child_count():
		if get_child(index).visible:
			return index
	return 0
	
