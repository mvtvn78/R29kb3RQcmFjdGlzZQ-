extends Node2D
@onready var body_sprite = $Sprite2D
# 
var body_keys = []
var color_keys =[]
var current_body_index = 0
var current_color_index = 0
func _ready() -> void:
	set_sprite_keys()
	update_sprite()
func set_sprite_keys():
	body_keys = Global.bodies_collection.keys()
func update_sprite():
	var current_sprite= body_keys[current_body_index]
	body_sprite.texture = Global.bodies_collection[current_sprite]
	body_sprite.modulate= Global.body_color_options[current_color_index]
	Global.selected_body = current_sprite
	Global.selected_body_color = Global.body_color_options[current_color_index]


func _on_collection_btn_pressed() -> void:
	current_body_index = (current_body_index + 1) % body_keys.size()
	update_sprite()


func _on_color_btn_pressed() -> void:
	current_color_index = (current_color_index  + 1) % Global.body_color_options.size()
	update_sprite()
