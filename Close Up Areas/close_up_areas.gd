class_name CloseUpAreasManager extends Node

var close_up_areas: Array[Node]

@onready var look_sides: Dictionary[StringName, Node] = {
	&"FRONT": %"Front Areas",
	&"RIGHT": %"Right Areas",
	&"BACK": %"Back Areas",
	&"LEFT": %"Left Areas"
}

@onready var go_back_button: GoBackButton = %"Go Back Button"
@onready var player: Player = %Player

func _ready() -> void:
	for look_side: Node in look_sides.values():
		close_up_areas.append_array(look_side.get_children())

	# Connects the signals for all the Close Up Areas
	for close_up_area: CloseUpArea in close_up_areas:
		close_up_area.player_close_up.connect(player.player_look_at)
		close_up_area.disable_collisions.connect(disable_collisions)

	go_back_button.pressed.connect(update_active_side)
	player.looking_dir.connect(update_active_side)

	# Set initial active side
	update_active_side(&"FRONT")

func update_active_side(current_side: StringName = player.current_look_dir_name) -> void:
	if not look_sides.has(current_side): return
	disable_collisions()
	enable_collisions(look_sides[current_side])

func disable_collisions() -> void:
	for close_up_area: CloseUpArea in close_up_areas:
		close_up_area.collision_shape.disabled = true

func enable_collisions(current_look_area: Node) -> void:
	for area: CloseUpArea in current_look_area.get_children():
		area.collision_shape.disabled = false
