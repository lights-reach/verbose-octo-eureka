extends State

@export var idle_state: State
@export var move_state: State
@onready var dashtimer: Timer = $"../../dashtimer"
@onready var ray: RayCast2D = $"../../RayCast2D"
@onready var ray2: RayCast2D = $"../../RayCast2D2"
static var dash_buffer_time = 0.1
var dash_buffer_timer: float = 0.0
var should_wait = false
var switch_side: String = "Left"
static var truedashspeed = 70000

func enter_state() -> void:
	get_parent().get_parent().sword_modes = "Disabled"
	PlayerGlobals.dashes -= 1
	dashtimer.start()
	get_parent().get_parent().can_dash = false
	get_parent().get_parent().velocity = Vector2.ZERO
	get_parent().get_parent().movement = "Dashing"
	dash_buffer_timer = dash_buffer_time
	if get_parent().get_parent().current_dir == "Left":
		
		if (ray.is_colliding() || ray2.is_colliding()):
			switch_side = "Left"
			get_parent().get_parent().dashspeed = truedashspeed
		else:
			switch_side = "don't"
			get_parent().get_parent().dashspeed = -truedashspeed
		
	if get_parent().get_parent().current_dir == "Right":
		
		if (ray.is_colliding() || ray2.is_colliding()):
			switch_side = "Right"
			get_parent().get_parent().dashspeed = -truedashspeed
		else:
			switch_side = "don't"
			get_parent().get_parent().dashspeed = truedashspeed

 
func  exit_state() -> void:
	if switch_side == "Left":
		if get_parent().get_parent().current_dir == "Left":
			get_parent().get_parent().current_dir = "Right"
	elif switch_side == "Right":
		if get_parent().get_parent().current_dir == "Right":
			get_parent().get_parent().current_dir = "Left"
