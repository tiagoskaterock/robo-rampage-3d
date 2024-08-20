extends Node3D

@export var fire_rate:= 14.0
@export var recoil:= 0.05
@export var weapon_mesh: Node3D
@export var weapon_damage := 15
@export var muzzle_flash : GPUParticles3D
var sparks: PackedScene = preload("res://Weapons/sparks.tscn")
@export var automatic: bool

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var sandbox = get_parent().get_parent().get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if automatic:
		if Input.is_action_pressed("fire") and cooldown_timer.is_stopped():
			shoot()
	else:
		if Input.is_action_just_pressed("fire") and cooldown_timer.is_stopped():
			shoot()
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)


func shoot() -> void:
	muzzle_flash.restart()
	shoot_fx()
	cooldown_timer.start(1.0 / fire_rate)
	var collider = ray_cast_3d.get_collider()
	weapon_mesh.position.z += recoil
	if collider is Enemy:
		collider.hitpoints -= weapon_damage
	add_sparks()


func shoot_fx():
	var pre_gun_shot : PackedScene = preload("res://FX/gun_shot.tscn")
	var gun_shot = pre_gun_shot.instantiate()
	var pre_rifle_shot : PackedScene = preload("res://FX/rifle_sfx.tscn")
	var rifle_shot = pre_rifle_shot.instantiate()
	sandbox.add_child(rifle_shot)
	
	
func add_sparks():
	var spark = sparks.instantiate()
	add_child(spark)
	spark.global_position = ray_cast_3d.get_collision_point()
