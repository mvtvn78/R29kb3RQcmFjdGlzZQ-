extends Node


var inventory = []
signal	inventory_updated
var player_node : Node = null
var spawnable_items = [
	{"type": "Cos1", "name" : "berry", "effect" : "Stamina", "texture": preload("res://Assets/Icons/icon3.png")},
	{"type": "Cos23", "name" : "berry", "effect" : "Stamina", "texture": preload("res://Assets/Icons/icon4.png")},
	{"type": "Cos32", "name" : "berry", "effect" : "Stamina", "texture": preload("res://Assets/Icons/icon7.png")},
]
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
func remove_item(item_type,item_effect):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] ==item_type and inventory[i]["effect"] == item_effect:
			inventory[i]["quantity"] -=1;
			if inventory[i]["quantity"] <=0 :
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false
func increase_inventory_size():
	inventory_updated.emit()
func set_player_reference(player):
	player_node = player
func adjust_drop_position(position):
	var radius = 100
	var nearby_item = get_tree().get_nodes_in_group("Items")
	for item in nearby_item:
		if item.global_position.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
			position += random_offset
			break
	return position
func drop_item(item_data,drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position  = adjust_drop_position(drop_position)
	item_instance.global_position= drop_position
	get_tree().current_scene.add_child(item_instance)
	
	
