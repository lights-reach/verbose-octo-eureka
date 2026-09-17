extends RigidBody2D
var randomX = randf_range(-200, 200)
var randomY = randf_range(-500, -200)
var can_pick_up = false
signal coin_collected

func _ready() -> void:
	lock_rotation = true

	apply_impulse(Vector2(randomX, randomY))


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if can_pick_up == true:
		PlayerGlobals.money += 1
		PlayerUi.connect("coin_collected", PlayerUi._on_coin_collected())
		coin_collected.emit()
		queue_free()

func jimooo():
	print("yo?")


func _on_timer_timeout() -> void:
	can_pick_up = true
