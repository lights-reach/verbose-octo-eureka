extends Area2D

@export_range(1, 500) var total_money: int
var current_money = 2
var coin = preload("res://Scenes/Cash/coin.tscn")

func _ready() -> void:
	current_money = total_money

func _process(_delta: float) -> void:
	if current_money <= 0:
		queue_free()





func _on_area_entered(area: Area2D) -> void:
	print("potato")
	if current_money > total_money / 3:
		for i in current_money / 3:
			var coin_inst = coin.instantiate()
			coin_inst.position = position
			get_parent().add_child(coin_inst)
			current_money -= 1
	else:
		for i in current_money:
			var coin_inst = coin.instantiate()
			coin_inst.position = position
			get_parent().add_child(coin_inst)
			current_money -= 1
