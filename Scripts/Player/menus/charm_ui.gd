extends Node2D
@onready var dark_charm_notch_leader: Sprite2D = $"Darkside/Dark charm notch leader"
@onready var dark_charm_notch: Sprite2D = $"Darkside/Dark charm notch"
@onready var dark_charm_notch_2: Sprite2D = $"Darkside/Dark charm notch2"
@onready var dark_charm_notch_3: Sprite2D = $"Darkside/Dark charm notch3"
@onready var dark_charm_notch_4: Sprite2D = $"Darkside/Dark charm notch4"
@onready var light_charm_notch_leader: Sprite2D = $"Lightside/Light charm notch Leader"
@onready var light_charm_notch_2: Sprite2D = $"Lightside/Light charm notch2"
@onready var light_charm_notch_3: Sprite2D = $"Lightside/Light charm notch3"
@onready var light_charm_notch_4: Sprite2D = $"Lightside/Light charm notch4"
@onready var light_charm_notch_5: Sprite2D = $"Lightside/Light charm notch5"

@onready var dark_tint: ColorRect = $ColorRect
@onready var light_tint: ColorRect = $ColorRect2
@onready var dark_mark: Marker2D = $Marker2D
@onready var light_mark: Marker2D = $Marker2D2
@onready var timer: Timer = $Timer
@onready var bar: ColorRect = $ColorRect3
@export_enum("Bar", "Charms") var selected = "Bar"
var current_pos: Vector2
var bar_pos: int = 0
var moving = false

func _process(_delta: float) -> void:
	if get_parent().is_paused == true:
		if selected == "Bar":
			if Input.is_action_just_pressed("Left"):
				if PlayerGlobals.dark_charm_notches != 0:
					if moving == false:
						var tween = create_tween()
						tween.tween_property(bar, "position", Vector2(current_pos.x - 56, 255), 0.1)
						timer.start()
						moving = true
						PlayerGlobals.dark_charm_notches -= 1
						PlayerGlobals.light_charm_notches += 1
						bar_pos -= 1
			elif Input.is_action_just_pressed("Right"):
				if PlayerGlobals.light_charm_notches != 0:
					if moving == false:
						var tween = create_tween()
						tween.tween_property(bar, "position", Vector2(current_pos.x + 56, 255), 0.1)
						timer.start()
						moving = true
						PlayerGlobals.dark_charm_notches += 1
						PlayerGlobals.light_charm_notches -= 1
						bar_pos += 1
	
	if current_pos != bar.position:
		current_pos = bar.position
	if dark_tint.position != bar.position:
		dark_tint.position = bar.position
	if light_tint.position != bar.position:
		light_tint.position = bar.position
	change_colors()




func _on_timer_timeout() -> void:
	moving = false






















func change_colors():
	if bar_pos == 0:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 0.5
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == 1:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		print(dark_tint.position.distance_to(dark_mark.position))
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 0.5
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 2
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == 2:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 1
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 2
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 2
	elif bar_pos == 3:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 1.5
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 2
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 2
		light_charm_notch_4.frame = 2
	elif bar_pos == 4:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 2
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 2
		light_charm_notch_2.frame = 2
		light_charm_notch_3.frame = 2
		light_charm_notch_4.frame = 2
	elif bar_pos == 5:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position)
		light_tint.size.x = light_tint.position.distance_to(light_mark.position) - 3
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 2
		light_charm_notch_leader.frame = 2
		light_charm_notch_5.frame = 2
		light_charm_notch_2.frame = 2
		light_charm_notch_3.frame = 2
		light_charm_notch_4.frame = 2
	if bar_pos == -1:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position) - 0.5
		light_tint.size.x = light_tint.position.distance_to(light_mark.position)
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 2
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 1
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == -2:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position) - 1
		light_tint.size.x = light_tint.position.distance_to(light_mark.position)
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 1
		dark_charm_notch_2.frame = 2
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 1
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == -3:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position) - 1.5
		light_tint.size.x = light_tint.position.distance_to(light_mark.position)
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 1
		dark_charm_notch_2.frame = 1
		dark_charm_notch_3.frame = 2
		dark_charm_notch_4.frame = 1
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == -4:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position) - 2
		light_tint.size.x = light_tint.position.distance_to(light_mark.position)
		dark_charm_notch_leader.frame = 2
		dark_charm_notch.frame = 1
		dark_charm_notch_2.frame = 1
		dark_charm_notch_3.frame = 1
		dark_charm_notch_4.frame = 1
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
	elif bar_pos == -5:
		dark_tint.size.x = dark_tint.position.distance_to(dark_mark.position) - 3.5
		light_tint.size.x = light_tint.position.distance_to(light_mark.position)
		dark_charm_notch_leader.frame = 1
		dark_charm_notch.frame = 1
		dark_charm_notch_2.frame = 1
		dark_charm_notch_3.frame = 1
		dark_charm_notch_4.frame = 1
		light_charm_notch_leader.frame = 1
		light_charm_notch_5.frame = 1
		light_charm_notch_2.frame = 1
		light_charm_notch_3.frame = 1
		light_charm_notch_4.frame = 1
