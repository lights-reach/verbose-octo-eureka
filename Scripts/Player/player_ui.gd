extends CanvasLayer
@onready var dash_meter: Sprite2D = $"Health and CORE/DashMeter"
var hearts_list: Array[TextureRect]
@onready var hearts_parent: HBoxContainer = $"Health and CORE/BoxContainer"
var just_hit: bool = false
@onready var player: CharacterBody2D = $Player
@onready var label: Label = $"Health and CORE/Sprite2D/Label"
@onready var label2: Label = $"Health and CORE/Label"
@onready var timer: Timer = $"Health and CORE/Label/Timer"
var player_cash = 0
var tween_running = false
var twang
var adjust_number = false
func _ready() -> void:
	
	player = get_tree().get_first_node_in_group("Player")
	visible = true
	player_cash = PlayerGlobals.money
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < player.health
	
func _process(_delta: float) -> void:
	label2.text = str("+", PlayerGlobals.money - player_cash)
	label.text = str(player_cash)
	if player_cash != PlayerGlobals.money:
		if tween_running == false && adjust_number == true:
			twang = create_tween()
			
		label2.visible = true
	else:
		label2.visible = false
	if adjust_number == true:
		tween_money(twang)
	
	# dash meter
	#region
	if PlayerGlobals.number_of_dashes == 0:
		dash_meter.visible = false
	elif PlayerGlobals.number_of_dashes == 1:
		dash_meter.visible = true
		if current_dashes(1):
			dash_meter.frame = 0
		if current_dashes(0):
			dash_meter.frame = 1
		
	elif PlayerGlobals.number_of_dashes == 2:
		dash_meter.visible = true
		if current_dashes(2):
			dash_meter.frame = 2
		if current_dashes(1):
			dash_meter.frame = 3
		if current_dashes(0):
			dash_meter.frame = 4
	elif PlayerGlobals.number_of_dashes == 3:
		dash_meter.visible = true
		if current_dashes(3):
			dash_meter.frame = 5
		if current_dashes(2):
			dash_meter.frame = 6
		if current_dashes(1):
			dash_meter.frame = 7
		if current_dashes(0):
			dash_meter.frame = 8
	elif PlayerGlobals.number_of_dashes == 4:
		dash_meter.visible = true
		if current_dashes(4):
			dash_meter.frame = 9
		if current_dashes(3):
			dash_meter.frame = 10
		if current_dashes(2):
			dash_meter.frame = 11
		if current_dashes(1):
			dash_meter.frame = 12
		if current_dashes(0):
			dash_meter.frame = 13
	#endregion
func current_dashes(dashee: int) -> bool:
	if dashee == PlayerGlobals.dashes:
		return true
	else:
		return false


func _on_player_hit(_lower_health: bool) -> void:
	for i in range(hearts_list.size()):
		if player.health > i:
			hearts_list[i].current_state = "full"
		elif player.health == i:
			hearts_list[i].current_state = "grow"
		elif player.health < i:
			hearts_list[i].current_state = "empty"



func tween_money(tween: Tween):
	
	if tween:
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "player_cash", PlayerGlobals.money, 0.05 * (PlayerGlobals.money - player_cash))
		if !tween.is_running():
			tween_running = false
			#tween.kill()
		else:
			tween_running = true


func _on_timer_timeout() -> void:
	adjust_number = true

func _on_coin_collected() -> Callable:
	adjust_number = false
	timer.start()
	return Callable(self, "print_args")
