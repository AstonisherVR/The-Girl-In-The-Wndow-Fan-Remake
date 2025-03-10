class_name PickUpItemsManager extends Node

@onready var go_back_button: GoBackButton = %"Go Back Button"
@onready var player: Player = %Player

func _ready() -> void:
	for item: BaseItem in get_children(): item.disable_all_items_collision.connect(disable_collisions)
	go_back_button.pressed.connect(disable_collisions)
	player.player_interacting.connect(enable_collisions)

func disable_collisions() -> void:
	for item: BaseItem in get_children():
		item.collision_shape.disabled = true

func enable_collisions() -> void:
	for item: BaseItem in get_children():
		item.collision_shape.disabled = false
