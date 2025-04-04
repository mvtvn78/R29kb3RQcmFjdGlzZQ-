extends Node2D


var playerName = ""
@onready var name_box = $CreatorScreen/ColorRect/Details/TextEdit

func _on_text_edit_text_changed() -> void:
	playerName = name_box.text


func _on_confirm_button_pressed() -> void:
	Global.playerName  = playerName
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
