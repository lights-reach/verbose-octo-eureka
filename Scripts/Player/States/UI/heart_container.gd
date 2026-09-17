extends TextureRect
@onready var empty: State = $StateMachine/Empty
@onready var full: State = $StateMachine/Full
@onready var healing: State = $StateMachine/Healling
var player = null
@export var heal = false
@export_range(1, 8) var heart_container_number = 1

signal switch_state(state: State)

var current_state = "full"

func _process(_delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	if current_state == "full":
		switch_state.emit(full)
	elif current_state == "grow":
		switch_state.emit(healing)
	else:
		switch_state.emit(empty)
	if heal == true:
		current_state = "full"
		player.heal(1)
		heal = false
