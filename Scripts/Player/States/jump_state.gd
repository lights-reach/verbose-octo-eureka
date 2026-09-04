extends State

@export var move_state: State
@export var idle_state: State
@export var dash_state: State
@export var fall_state: State
@export var attack_state: State
static var jump_height = 21500
static var speed = 11500
func enter_state() -> void:
	get_parent().get_parent().movement = "Walking"
	get_parent().get_parent().sword_modes = "All dir"

func _physics_state(_delta: float) -> void:
	
	if get_parent().get_parent().coyote_timer > 0:
		get_parent().get_parent().velocity.y = 0
		get_parent().get_parent().velocity.y = -jump_height * _delta
		get_parent().get_parent().jump_buffer_timer = 0
		get_parent().get_parent().coyote_timer = 0
	
