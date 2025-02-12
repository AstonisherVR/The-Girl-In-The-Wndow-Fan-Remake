extends Node3D

@onready var inventory: InventoryResource = preload("res://Player/Player_Inventory_Data.tres")
@export var rotation_duration: float = 0.2	# Seconds
enum CloseUpStates {CENTER_OF_ROOM, COAT_RACK, LIGHT_SWITCH, FLOOR_PLANK, DRAWER, PIPE, TV, VCR,
					POWER_CABLE, UPER_SHELF_CABINET, LOWER_SHELF_CABINET, BOOKS, NUMBERS_PUZZLE_BOX,
					SYMBOLS_PUZZLE_CABINET, FIGURE_PUZZLE_CABINET, VAMPIRE, MOUSE, PLANT_WITH_STONE,
					COUCH, FAKE_PLUG, NEWS, TABLE, WINDOW, DRAWER_WITH_PHOTO}

var current_look_at_state: CloseUpStates = CloseUpStates.CENTER_OF_ROOM

const ROTATION_ANGLE: int = 90
enum TurnDirection {LEFT = 1, RIGHT = -1}
var is_turning: bool = false
var target_rotation: float = 0.0

func _ready() -> void:
	configure_position()

func _input(event: InputEvent) -> void:
	if is_turning: return	# No need to check the turn dir if the player is already turning
	if event.is_action_pressed("LEFT"):
		turn(TurnDirection.LEFT)
	elif event.is_action_pressed("RIGHT"):
		turn(TurnDirection.RIGHT)

func turn(turn_dir: int) -> void:
	is_turning = true
	target_rotation += deg_to_rad(ROTATION_ANGLE * turn_dir)
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation:y", target_rotation, rotation_duration)
	await tween.finished
	is_turning = false

func configure_position() -> void:
	#match position_states
	match current_look_at_state:
		CloseUpStates.CENTER_OF_ROOM:
			position= Vector3.ZERO
			return
