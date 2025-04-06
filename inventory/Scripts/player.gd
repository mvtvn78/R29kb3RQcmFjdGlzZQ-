extends CharacterBody2D

var speed = 200
@onready var animated_sprite = $AnimatedSprite2D
@onready var iteract_ui = $InteractUI
@onready var inventory_ui = $InventoryUI
func _ready() -> void:
	Global.set_player_reference(self)
func get_input():
	var input_dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = input_dir * speed
func _physics_process(delta: float) -> void:
	get_input()
	update_animations()
	move_and_slide()
func update_animations():
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else :
			if velocity.y > 0 :
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = ! inventory_ui.visible
		#Pause game
		get_tree().paused = ! get_tree().paused
func apply_item_effect(item):
	match item["effect"]:
		"Stamina": 
			speed +=50
			print("Speed increase to ", speed)
		_:
			print("No effect for this item")
