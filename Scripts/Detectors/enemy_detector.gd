extends Area2D

var enemies = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function _body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	enemies += 1


func _on_body_exited(_body: Node2D) -> void:
	enemies -= 1
