extends CharacterBody2D

@export var speed: int = 150
@export var health: int = 3
@export var damage: int = 1
@export var gravity: int = 3
@onready var ray: RayCast2D = $RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $"detection circle/CollisionShape2D"
@export var detection_radi: int = 70
var decelerate = false
var knockback_vel: Vector2
var locked_on = false
@export var knockback_forcee = 170
@export var knockback_time = 0.2
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("Player"):
		player = i


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if locked_on == true && knockback_vel.x <= 10:
		chase()
	else:
		wander()
	
	if knockback_vel:
		velocity = knockback_vel
	
	#if decelerate:
		#velocity = lerp(velocity, Vector2.ZERO, 0.1)
	#	knockback_vel = lerp(knockback_vel, Vector2.ZERO, 0.1)
		#await get_tree().create_timer(0.1).timeout
		#decelerate = true
	
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	locked_on = true
	
	collision_shape_2d.shape.radius = detection_radi * 1.5



func _on_area_2d_body_exited(_body: Node2D) -> void:
	locked_on = false
	
	collision_shape_2d.shape.radius = detection_radi

func chase():
	if player.position > position:
		ray.target_position = Vector2(10, 11)
		if ray.is_colliding():
			velocity.x = speed
		else:
			velocity.x = 0
	elif player.position < position:
		ray.target_position = Vector2(-10, 11)
		if ray.is_colliding():
			velocity.x = -speed
		else:
			velocity.x = 0
	else:
		velocity.x = 0
	await get_tree().create_timer(0.1).timeout
func wander():
	velocity.x = 0


func _on_area_2d_2_area_entered(_area: Area2D) -> void:
	health -= 1
	
	var knockback_direction = player.global_position.direction_to(global_position)
	knockback_direction.y = 0
	get_knockback(knockback_direction, knockback_forcee)
	if health <= 0:
		queue_free()

func get_knockback(knockback_dir, knockback_force):
	knockback_vel = knockback_dir * knockback_force
	
	
	await get_tree().create_timer(knockback_time).timeout
	knockback_vel = Vector2.ZERO
	#decelerate = true
