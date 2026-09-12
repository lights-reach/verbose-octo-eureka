extends Area2D

var ascend = false
var player = null
var time = 0.3
var timer = 0.0
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	timer += 1 * _delta
	if ascend == true:
		player.velocity.y -= 3

func _on_body_entered(_body: Node2D) -> void:
	if timer >= time:
		_body.velocity.y -= 400
		ascend = true
