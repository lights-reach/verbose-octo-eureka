extends CharacterBody2D

@export var speed: int = 50
@export var health: int = 3
@export var damage: int = 1
@export var gravity: int = 3
@onready var ray: RayCast2D = $RayCast2D
@export var detection_radi: int = 70
var decelerate = false
var knockback_vel: Vector2
var locked_on = true
var dir = "Left"
@export var knockback_forcee = 170
@export var knockback_time = 0.2
@export var stop_time: float = 1.0
@export var move_time: float = 5.0
var player
@onready var timer_2: Timer = $Timer2
@onready var timer: Timer = $Timer
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
	
	
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()

func chase():
	if dir == "Left":
		ray.position = Vector2(-9, 4)
		ray.target_position = Vector2(-2, 4)
		velocity.x = -speed
	elif dir == "Right":
		ray.position = Vector2(-9, 4)
		ray.target_position = Vector2(2, 4)
		velocity.x = speed
	else:
		velocity.x = 0
	if !ray.is_colliding():
		if dir == "Left":
			dir = "Right"
		elif dir == "Right":
			dir = "Left"
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
