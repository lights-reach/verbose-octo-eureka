extends CanvasLayer
@onready var dash_meter: Sprite2D = $DashMeter
var hearts_list: Array[TextureRect]
@onready var hearts_parent: HBoxContainer = $BoxContainer
@onready var player: CharacterBody2D = $"../Player"
var just_hit: bool = false



func _ready() -> void:
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < player.health
		
func _process(_delta: float) -> void:
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
