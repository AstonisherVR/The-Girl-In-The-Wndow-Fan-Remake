extends Node3D

var close_up_state_positions: Dictionary[String, Vector3] = {
	"CENTER_OF_ROOM": Vector3.ZERO,
	"COAT_RACK": Vector3(-2, 1, -2),
	"LIGHT_SWITCH": Vector3(0, 1, -2),
	"FLOOR_PLANK": Vector3(1, 0, -1),
	}

#@export var CloseUpStates: Array[String] = ["CENTER_OF_ROOM", "COAT_RACK", "LIGHT_SWITCH", "FLOOR_PLANK", "DRAWER",
				#"PIPE", "TV", "VCR", "POWER_CABLE", "UPER_SHELF_CABINET", "LOWER_SHELF_CABINET", "BOOKS",
				#"NUMBERS_PUZZLE_BOX", "SYMBOLS_PUZZLE_CABINET", "FIGURE_PUZZLE_CABINET", "VAMPIRE", "MOUSE",
				#"PLANT_WITH_STONE", "COUCH", "FAKE_PLUG", "NEWS", "TABLE", "WINDOW", "DRAWER_WITH_PHOTO"]

@onready var inventory: InventoryResource = preload("res://Player/Player_Inventory_Data.tres")
@onready var go_back_button: TextureButton = %"Go Back Button"
@onready var close_up_areas: Node3D = %"Close Up Areas"
@export var rotation_duration: float = 0.2	# Seconds

var current_rotation: float
var previous_position: Vector3
var can_turn: bool = true

func _ready() -> void:
	go_back_button.hide()
	connect_close_up_areas()

func connect_close_up_areas() -> void:
	for area: InteractArea in close_up_areas.get_children():
		area.player_close_up.connect(player_look_at)

func _input(event: InputEvent) -> void:
	if !can_turn: return	# No need to check the turn dir if the player is already turning
	if event.is_action_pressed("LEFT"): turn(1)
	elif event.is_action_pressed("RIGHT"): turn(-1)

func turn(turn_dir: int) -> void:
	can_turn = false
	current_rotation += deg_to_rad(90 * turn_dir)
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation:y", current_rotation, rotation_duration)
	await tween.finished
	can_turn = true

func player_look_at(state_to_be: String) -> void:
	if not(state_to_be in close_up_state_positions):
		push_error("Warning: Unknown state ", state_to_be)
		return
	previous_position = position
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.set_parallel()
	#tween.tween_property(self, "rotation:y", 0.1, rotation_duration)
	tween.tween_property(self, "position", close_up_state_positions[state_to_be], rotation_duration)
	go_back_button.show()
	can_turn = false

func _on_go_back_button_pressed() -> void:
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.set_parallel()
	#tween.tween_property(self, "rotation:y", 0.1, rotation_duration)
	tween.tween_property(self, "position", previous_position, rotation_duration)
	go_back_button.hide()
	can_turn = true
