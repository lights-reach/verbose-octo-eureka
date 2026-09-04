extends State

@export var idle_state: State
@export var jump_state: State
@export var dash_state: State
@export var fall_state: State
@export var attack_state: State
@onready var jump_wear_off_timer: Timer = $"../../jump_wear_off_timer"

func update(_delta: float) -> void:
	get_parent().get_parent().movement = "Walking"
	get_parent().get_parent().sword_modes = "No pogo"
	get_parent().get_parent().lerp_movement = false


func _physics_state(_delta: float) -> void:
	if get_parent().get_parent().is_on_floor():
		PlayerGlobals.dashes = PlayerGlobals.number_of_dashes
		
