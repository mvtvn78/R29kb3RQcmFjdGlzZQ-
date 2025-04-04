extends Node2D
@onready var accessories_sprite = $Sprite2D
# 
var accessories_keys = []
var color_keys =[]
var current_accessories_index = 0
var current_color_index = 0
func _ready() -> void:
	set_sprite_keys()
	update_sprite()
func set_sprite_keys():
	accessories_keys = Global.accessories_collection.keys()
func update_sprite():
	var current_sprite= accessories_keys[current_accessories_index]
	if current_sprite == 'none':
		accessories_sprite.texture = null
	else:
		accessories_sprite.texture = Global.accessories_collection[current_sprite]
		accessories_sprite.modulate= Global.color_options[current_color_index]
	Global.selected_accessories = current_sprite
	Global.selected_accessories_color = Global.color_options[current_color_index]


func _on_collection_btn_pressed() -> void:
	current_accessories_index = (current_accessories_index + 1) % accessories_keys.size()
	update_sprite()


func _on_color_btn_pressed() -> void:
	current_color_index = (current_color_index + 1) %  Global.color_options.size()
	update_sprite()
