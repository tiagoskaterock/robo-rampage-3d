extends Node3D

@export var weapon_7 : Node3D
@export var weapon_8 : Node3D

var pre_gun_load = preload("res://FX/gun_load.tscn")

func _ready() -> void:
	equip(weapon_7)

func equip(active_weapon : Node3D) -> void:
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
		else:
			child.visible = false
			child.set_process(false)
	
		
func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed('weapon_7'):
		equip(weapon_7)
		gun_load_sfx()
	if event.is_action_pressed('weapon_8'):
		equip(weapon_8)
		gun_load_sfx()


func gun_load_sfx():
	var gun_load = pre_gun_load.instantiate()
	get_parent().add_child(gun_load)
