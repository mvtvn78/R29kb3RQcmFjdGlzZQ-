extends CharacterBody2D
var last_dir = Vector2.ZERO	
const speed = 200
# Node Ref
@onready var body = $Skeleton/Body
@onready var hair = $Skeleton/Hair
@onready var outfit =$Skeleton/Outfit
@onready var accessory =$Skeleton/Accessory
@onready var nameLabel  =$Skeleton/Name
@onready var animation_player = $AnimationPlayer
@onready var audio_walk =$Audio_walk
func _ready() -> void:
	intialize_player()
func  _physics_process(delta: float) -> void:		
	var dir = Vector2.ZERO	
	dir.x = Input.get_axis("ui_left","ui_right")
	dir.y = Input.get_axis("ui_up","ui_down")
	# store last direction
	if dir != last_dir:
		last_dir = dir
	# update direction and velocity
	if dir.x != 0:
		#velocity.x = dir.x * speed
		if dir.x< 0:
			animation_player.play("walk_left")
		else :
			animation_player.play("walk_right")
		if ! audio_walk.playing : 
			audio_walk.play()
	if dir.y != 0:
		#velocity.y = dir.y * speed
		if dir.y< 0:
			animation_player.play("walk_up")
		else :
			animation_player.play("walk_down")
		if ! audio_walk.playing : 
			audio_walk.play()
	if dir == Vector2.ZERO:
		audio_walk.stop()
		if last_dir.x < 0: 
			animation_player.play("idle_left")
		if last_dir.x > 0:
			animation_player.play("idle_right")
		if last_dir.y < 0:
			animation_player.play("idle_up")
		if last_dir.y > 0 :
			animation_player.play("idle_down")
	move_and_slide()
func intialize_player():
	body.texture = Global.bodies_collection[Global.selected_body]
	body.modulate  = Global.selected_body_color
	outfit.texture = Global.outfit_collection[Global.selected_outfit]
	outfit.modulate =  Global.selected_outfit_color
	if Global.selected_hair != "none":
		hair.texture = Global.hair_collection[Global.selected_hair]
		hair.modulate = Global.selected_hair_color
	if Global.selected_accessories != "none":
		accessory.texture = Global.accessories_collection[Global.selected_accessories]
		accessory.modulate = Global.selected_accessories_color
	nameLabel.text= Global.playerName
