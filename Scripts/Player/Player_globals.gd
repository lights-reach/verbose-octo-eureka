extends Node

var last_checkpoint: Vector2
var number_of_dashes: int
var dashes: int
var max_health = 5
var max_charm_notches = 10
var dark_charm_notches = 5
var light_charm_notches = 5

var room_dir: String
var can_move: bool = true
var starting_state: String
var starting_position: Vector2
var player_dir
