extends CharacterBody2D

@export var speed: int = 100
@export var health: int = 3
@export var damage: int = 1
@onready var collision_shape_2d: CollisionShape2D = $"detection circle/CollisionShape2D"
@export var detection_radi: int = 140
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var direction: Vector2
var decelerate = false
var knockback_vel: Vector2
var locked_on = false
var knockback_forcee = 170
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("Player"):
		player = i


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if locked_on == true && knockback_vel.x <= 10:
		chase(_delta)
	else:
		wander()
	
	if knockback_vel:
		velocity = knockback_vel
	
	#if decelerate:
		#velocity = lerp(velocity, Vector2.ZERO, 0.1)
	#	knockback_vel = lerp(knockback_vel, Vector2.ZERO, 0.1)
		#await get_tree().create_timer(0.1).timeout
		#decelerate = true
	
	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	locked_on = true
	




func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass

func chase(_delta: float):
	navigation_agent_2d.target_position = player.global_position
	direction = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	
	if navigation_agent_2d.is_target_reached() == false:
		velocity = direction * speed
		
	

func wander():
	velocity.x = 0
	velocity.y = 0


func _on_area_2d_2_area_entered(_area: Area2D) -> void:
	health -= 1
	
	var knockback_direction = player.global_position.direction_to(global_position)
	get_knockback(knockback_direction, knockback_forcee)
	if health <= 0:
		queue_free()

func get_knockback(knockback_dir, knockback_force):
	knockback_vel = knockback_dir * knockback_force
	
	
	await get_tree().create_timer(0.2).timeout
	knockback_vel = Vector2.ZERO
	#decelerate = true
