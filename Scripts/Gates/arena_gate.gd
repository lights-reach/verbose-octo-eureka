extends StaticBody2D

@export var player_detector: Area2D
@export var enemy_detector: Area2D
@export var enemys_required: int
@onready var collision: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	collision.disabled = true


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_detector.detecting == true:
		visible = true
		collision.disabled = false
	if enemy_detector.enemies <= 0:
		queue_free()
