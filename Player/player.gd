extends Node3D

@onready var inventory: InventoryResource = preload("res://Player/Player_Inventory_Data.tres")
@onready var go_back_button: TextureButton = %"Go Back Button"
@onready var close_up_areas: Node = %"Close Up Areas"
@export var rotation_duration: float = 0.2	# Seconds

var current_rotation: float
var previous_position: Vector3
var can_turn: bool = true

func _ready() -> void:
	go_back_button.hide()
	connect_close_up_areas()

func connect_close_up_areas() -> void:
	for area: CloseUpArea in close_up_areas.get_children(): area.player_close_up.connect(player_look_at)

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

var close_up_state_positions: Dictionary[String, Vector3] = {
	"CENTER_OF_ROOM": Vector3.ZERO, "COAT_RACK": Vector3(-2, 1, -2),
	"LIGHT_SWITCH": Vector3(0, 1, -2), "FLOOR_PLANK": Vector3(-3, -0.5, -1),
	"DRAWER": Vector3.ONE, "PIPE": Vector3.ONE,
	"TV": Vector3.ONE, "VCR": Vector3.ONE,
	"POWER_CABLE": Vector3.ZERO, "UPER_SHELF_CABINET": Vector3.ONE,
	"LOWER_SHELF_CABINET": Vector3.ONE, "BOOKS": Vector3.ONE,
	"NUMBERS_PUZZLE_BOX": Vector3.ZERO, "SYMBOLS_PUZZLE_CABINET": Vector3.ONE,
	"FIGURE_PUZZLE_CABINET": Vector3.ONE, "VAMPIRE": Vector3.ONE,
	"MOUSE": Vector3.ZERO, "PLANT_WITH_STONE": Vector3.ONE,
	"COUCH": Vector3.ONE, "FAKE_PLUG": Vector3.ONE,
	"NEWS": Vector3.ZERO, "TABLE": Vector3.ONE,
	"WINDOW": Vector3.ONE, "DRAWER_WITH_PHOTO": Vector3.ONE,

	}

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
