extends Area2D

@onready var marker_2d: Marker2D = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function _body.


# Called every frame. '(_delta: float)' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	
	PlayerGlobals.last_checkpoint = marker_2d.global_position
