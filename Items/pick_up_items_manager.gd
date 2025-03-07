class_name PickUpItemsManager extends Node

@onready var go_back_button: GoBackButton = %"Go Back Button"
@onready var player: Player = %Player
@onready var close_up_areas_manager: CloseUpAreasManager = %"Close Up Areas Manager"

func _ready() -> void:
	for item: BaseItem in get_children():
		item.disable_all_items_collision.connect(disable_collisions)
	close_up_areas_manager.player_interacting.connect(enable_collisions)
	#player.player_close_up.c

func disable_collisions() -> void:
	for item: BaseItem in get_children():
		item.collision_shape.disabled = true

func enable_collisions() -> void:
	for item: BaseItem in get_children():
		item.collision_shape.disabled = false
