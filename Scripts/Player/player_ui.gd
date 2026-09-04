extends CanvasLayer
@onready var dash_meter: Sprite2D = $DashMeter

func _process(delta: float) -> void:
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

func current_dashes(dashee: int) -> bool:
	if dashee == PlayerGlobals.dashes:
		return true
	else:
		return false
