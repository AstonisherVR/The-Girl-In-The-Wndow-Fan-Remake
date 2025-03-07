extends Node
@onready var close_up_areas: Array[Node] = get_children()
@onready var go_back_button: GoBackButton = %"Go Back Button"
@onready var player: Player = %Player

func _ready() -> void:
	for close_up_area: CloseUpArea in close_up_areas:
		close_up_area.player_close_up.connect(player.player_look_at)
		close_up_area.disable_collisions.connect(disable_collisions)
		go_back_button.pressed.connect(close_up_area.reset)

func disable_collisions() -> void:
	for close_up_area: CloseUpArea in close_up_areas:
		close_up_area.collision_shape.disabled = true
