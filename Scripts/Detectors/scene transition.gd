extends Area2D

@export var new_room: String
@export_enum("Idle", "Walking", "Dashing", "Jumping", "Falling") var state: String
@export_enum("Right", "Left", "Down", "Jumping") var direction: String
@export var player_position: Vector2
@export var can_move: bool = false
var enter_timer = 0
var enter_time = 0.2

func _process(delta: float) -> void:
	enter_timer += 1 * delta

func _on_body_entered(body: Node2D) -> void:
	if enter_timer > enter_time:
		PlayerGlobals.starting_position = player_position 
		PlayerGlobals.can_move = can_move
		PlayerGlobals.starting_state = state
		if body.current_dir == "Left" && direction == "Jumping":
			PlayerGlobals.room_dir = "Left Jump"
		elif body.current_dir == "Right" && direction == "Jumping":
			PlayerGlobals.room_dir = "Right Jump"
		else:
			PlayerGlobals.room_dir = direction
		PlayerGlobals.player_dir = body.current_dir
		SceneFader.change_scenes(new_room)
