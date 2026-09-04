extends State

@export var move_state: State
@export var jump_state: State
@export var dash_state: State
@export var fall_state: State
@export var attack_state: State
@onready var jump_wear_off_timer: Timer = $"../../jump_wear_off_timer"

func enter_state() -> void:
	get_parent().get_parent().velocity.x = 0
	get_parent().get_parent().movement = "Idle"
	get_parent().get_parent().sword_modes = "No pogo"
