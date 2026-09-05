extends State
@onready var anim: AnimationPlayer = $"../../AnimatedSprite2D/AnimationPlayer"

func enter_state() -> void:
	anim.play("Empty")
