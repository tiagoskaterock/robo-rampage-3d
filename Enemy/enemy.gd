extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player
var provoked := false
var aggro_range := 12.0
@export var attack_range := 1.5

func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(_delta):
	if provoked:
		navigation_agent_3d.target_position = player.global_position
	

func _physics_process(delta):
	var next_position = navigation_agent_3d.get_next_path_position()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction = global_position.direction_to(next_position)
	
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= aggro_range:
		provoked = true
		
	if provoked and distance < attack_range:
		attack()

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
	animation_player.play("Attack")
