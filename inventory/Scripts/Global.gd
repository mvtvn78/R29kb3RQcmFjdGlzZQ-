extends Node


var inventory = []
signal	inventory_updated
var player_node : Node = null
@onready var inventory_slot_scene= preload("res://Scenes/inventory_slot.tscn")

func _ready() -> void:
	inventory.resize(12)
	
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["type"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("Item added")
			print(inventory)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("Item added")
			print(inventory)
			return true
	return false
func remove_item():
	inventory_updated.emit()
func increase_inventory_size():
	inventory_updated.emit()
func set_player_reference(player):
	player_node = player
