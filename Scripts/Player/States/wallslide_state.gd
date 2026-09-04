extends State

@export var idle_state: State
@export var move_state: State
@export var dash_state: State
@export var fall_state: State
var jump_height = 21500
var side_movement = 15000
var switch_side: String = "Left"
var switch = true
@onready var ray: RayCast2D = $"../../RayCast2D"
@onready var ray2: RayCast2D = $"../../RayCast2D2"

func enter_state() -> void:
	get_parent().get_parent().wall_sliding = true
	get_parent().get_parent().movement = "Idle"
	get_parent().get_parent().sword_modes = "Reversed"

func update(_delta: float) -> void:
	get_parent().get_parent().wall_slide_timer = get_parent().get_parent().wall_slide_time

func _physics_state(_delta: float) -> void:
	
	if Input.get_axis("Left", "Right"):
		if Input.is_action_pressed("Down"):
			get_parent().get_parent().term_vel = 250
		else:
			get_parent().get_parent().term_vel = 100
	if get_parent().get_parent().current_dir == "Left":
		switch_side = "Left"
	else:
		switch_side = "Right"
	if get_parent().get_parent().jump_buffer_timer > 0:
		if get_parent().get_parent().current_dir == "Left":
			switch_side = "Left"
			if (ray.is_colliding() || ray2.is_colliding()):
				get_parent().get_parent().velocity.x = side_movement * _delta
				get_parent().get_parent().velocity.y = -jump_height * _delta
			else:
				get_parent().get_parent().velocity.x = -side_movement * _delta
				get_parent().get_parent().velocity.y = -jump_height * _delta
		elif get_parent().get_parent().current_dir == "Right":
			if (ray.is_colliding() || ray2.is_colliding()):
				get_parent().get_parent().velocity.x = -side_movement * _delta
				get_parent().get_parent().velocity.y = -jump_height * _delta
			else:
				get_parent().get_parent().velocity.x = side_movement * _delta
				get_parent().get_parent().velocity.y = -jump_height * _delta
		get_parent().get_parent().jump_buffer_timer = 0
		get_parent().get_parent().can_move = false
		get_parent().get_parent().timer.start()
func exit_state() -> void:
	get_parent().get_parent().term_vel = 350
	get_parent().get_parent().wall_sliding = false
	if switch:
		if !Input.is_action_just_pressed("dash"):
			if switch_side == "Left":
				get_parent().get_parent().current_dir = "Right"
			if switch_side == "Right":
				get_parent().get_parent().current_dir = "Left"
	else:
		switch = true
