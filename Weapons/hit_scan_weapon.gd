extends Node3D

@export var fire_rate:= 14.0
@export var recoil:= 0.05
@export var weapon_mesh: Node3D
@export var weapon_damage := 15

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var sandbox = get_parent().get_parent().get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fire") and cooldown_timer.is_stopped():
		shoot()
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)


func shoot() -> void:
	shoot_fx()
	cooldown_timer.start(1.0 / fire_rate)
	var collider = ray_cast_3d.get_collider()
	weapon_mesh.position.z += recoil	
	if collider is Enemy:
		collider.hitpoints -= weapon_damage
		

func shoot_fx():
	var pre_gun_shot : PackedScene = preload("res://FX/gun_shot.tscn")
	var gun_shot = pre_gun_shot.instantiate()	
	sandbox.add_child(gun_shot)
	
