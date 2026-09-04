extends State

@onready var jump_wear_off_timer: Timer = $"../../jump_wear_off_timer"
@export var idle_state: State
@export var move_state: State
@export var dash_state: State
@export var jump_state: State
@export var wallslide_state: State
@export var attack_state: State
@onready var ray: RayCast2D = $"../../RayCast2D"
@onready var ray2: RayCast2D = $"../../RayCast2D2"
static var speed = 11500



func _physics_state(_delta: float) -> void:
	get_parent().get_parent().movement = "Walking"
	get_parent().get_parent().sword_modes = "All dir"
