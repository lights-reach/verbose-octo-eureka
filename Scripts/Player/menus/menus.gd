extends Node2D

var is_paused = false
var player = null
@export_enum("Charms") var menus
@onready var charm_ui: Node = $"Charm UI"

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menus") && player.is_on_floor():
		if is_paused:
			player.paused = false
			is_paused = false
		else:
			player.paused = true
			is_paused = true
	if is_paused:
		if menus == "Charms":
			pass

func _physics_process(_delta: float) -> void:
	if is_paused:
		var tween = create_tween()
		tween.parallel()
		tween.tween_property(self, "modulate:a", 1, 0.1 )
		tween.tween_property(charm_ui, "modulate:a", 1, 0.1 )
	else:
		var tween = create_tween()
		tween.parallel()
		tween.tween_property(self, "modulate:a", 0, 0.1 )
		tween.tween_property(charm_ui, "modulate:a", 0, 0.1 )
