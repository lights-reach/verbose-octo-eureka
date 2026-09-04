class_name StateMachine extends Node

@export var initial_state: State

var active_state: State:
	set(new_value):
		active_state = new_value
		print("Changed to ", active_state.name)
func _ready() -> void:
	
	var child_state = get_parent()
	child_state.switch_state.connect(change_state)
	
	change_state(initial_state)

func _process(_delta: float) -> void:
	if active_state:
		active_state.update(_delta)

func _physics_process(_delta: float) -> void:
	if active_state:
		active_state._physics_state(_delta)

func change_state(new_state: State) -> void:
	if new_state == active_state:
		return
	
	if active_state:
		active_state.exit_state()
	
	active_state = new_state
	
	if active_state:
		active_state.enter_state()
	
