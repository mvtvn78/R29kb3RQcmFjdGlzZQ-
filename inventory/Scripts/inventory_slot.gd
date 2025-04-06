extends Control

@onready var icon = $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel
@onready var usage_btn = $UsagePanel/UseBtn
@onready var drop_btn = $UsagePanel/DropBtn
var item = null

func _on_item_button_pressed() -> void:
	print("Press")
	if item != null:
		usage_panel.visible = ! usage_panel.visible


func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true 


func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false 



func set_empty():
	icon.texture = null
	quantity_label.text = ""
func set_item(new_item):
	item = new_item
	icon.texture = item["texture"]
	quantity_label.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str(item["effect"])
	else:
		item_effect.text =""


func _on_drop_btn_pressed() -> void:
	if item !=null:
		var drop_position = Global.player_node.global_position 
		var drop_offset = Vector2(0,50)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item,drop_position + drop_offset)
		Global.remove_item(item["type"],item["effect"])


func _on_use_btn_pressed() -> void:
	usage_panel.visible  =false
	if item != null :
		if Global.player_node:
			Global.player_node.apply_item_effect(item)
			Global.remove_item(item["type"],item["effect"])
