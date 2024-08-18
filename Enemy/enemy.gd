extends CharacterBody3D
class_name Enemy

const SPEED = 4.0
const JUMP_VELOCITY = 4.5

@export var max_hitpoints := 100
@export var attack_range := 1.5
@export var attack_damage := 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sandbox = get_parent().get_parent()


var player
var distance
var provoked := false
var aggro_range := 12.0
var pre_death_scream = preload("res://FX/enemy_death_scream.tscn")
var hitpoints: int = max_hitpoints:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			die()
		provoked = true


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(_delta):
	if provoked:
		navigation_agent_3d.target_position = player.global_position
	

func _physics_process(delta):
	var next_position = navigation_agent_3d.get_next_path_position()
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction = global_position.direction_to(next_position)
	
	distance = global_position.distance_to(player.global_position)
	
	if distance <= aggro_range:
		provoked = true
		
	if provoked:
		if distance < attack_range:
			animation_player.play("Attack")
		else:
			animation_player.stop()

	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	


func look_at_target(direction: Vector3) -> void:
	var ajusted_direction = direction
	ajusted_direction.y = 0
	look_at(global_position + ajusted_direction, Vector3.UP, true)



func attack() -> void:
	if player.is_alive:
		if distance <= attack_range:
			roar()
			player.hitpoints -= attack_damage
			player.take_damage()
	else:
		$AnimationPlayer.stop()
	
	
func roar():
	var pre_roar = preload("res://FX/enemy_roar.tscn")
	var roar = pre_roar.instantiate()
	sandbox.add_child(roar)


func die():
	var death_scream = pre_death_scream.instantiate()
	get_parent().add_child(death_scream)
	set_physics_process(false)
	$TimerToDie.start()
	

func _on_timer_to_die_timeout():
	queue_free()
