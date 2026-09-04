extends State
@onready var ray: RayCast2D = $"../../RayCast2D"
@onready var ray2: RayCast2D = $"../../RayCast2D2"
@onready var sword_anim: AnimationPlayer = $"../../sword/AnimationPlayer"
@onready var sword: Area2D = $"../../sword"
@export var move_state: State
@export var jump_state: State
@export var dash_state: State
@export var fall_state: State
@export var idle_state: State
@export var can_chage_state = false

func update(_delta: float) -> void:
	get_parent().get_parent().movement = "Walking"



func _physics_state(_delta: float) -> void:
	pass
	
	
