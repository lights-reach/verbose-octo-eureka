class_name State extends Node

signal switch_state(state: State)

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func _physics_state(_delta: float) -> void:
	pass
