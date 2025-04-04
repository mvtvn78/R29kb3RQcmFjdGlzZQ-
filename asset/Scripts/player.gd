extends CharacterBody2D
var last_dir = Vector2.ZERO	
const speed = 200
# Node Ref
@onready var body = $Skeleton/Body
@onready var hair = $Skeleton/Hair
@onready var outfit =$Skeleton/Outfit
@onready var accessory =$Skeleton/Accessory
@onready var nameLabel  =$Skeleton/Name
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
		velocity.x = dir.x * speed
	else :
		velocity.x = move_toward(velocity.x,0,speed * delta)
	if dir.y != 0:
		velocity.y = dir.y * speed
	else :
		velocity.y = move_toward(velocity.y,0,speed * delta)
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
		hair.texture = Global.accessories_collection[Global.selected_accessories]
		hair.modulate = Global.selected_accessories_color
	nameLabel.text= Global.playerName
