class_name Player extends Node3D

signal looking_dir(side_name: StringName)

@onready var inventory: InventoryResource = preload("res://Player/Player_Inventory_Data.tres")
@onready var go_back_button: TextureButton = %"Go Back Button"
@export var move_wait_time: float = 0.15	# Seconds

var look_directions: Array = [&"FRONT", &"LEFT", &"BACK", &"RIGHT"]
var current_look_dir_index: int = 0 # Start facing "FRONT"
var current_look_dir_name: StringName = look_directions[current_look_dir_index]
var current_look_dir_degrees: int = 0

var previous_position: Vector3
var can_turn: bool = true

func _ready() -> void:
	go_back_button.hide()

func _input(event: InputEvent) -> void:
	if not can_turn: return	# No need to check the turn dir if the player is already turning
	if event.is_action_pressed("LEFT"): turn(1)
	elif event.is_action_pressed("RIGHT"): turn(-1)

func turn(turn_dir: int) -> void:
	can_turn = false
	current_look_dir_degrees += 90 * turn_dir
	var tween: Tween = create_my_tween()
	tween.tween_property(self, "rotation_degrees:y", current_look_dir_degrees, move_wait_time)
	update_look_side(turn_dir)
	await tween.finished
	can_turn = true

func player_look_at(state_to_be: Vector3) -> void:
	previous_position = position
	var tween: Tween = create_my_tween()
	#tween.set_parallel()
	#tween.tween_property(self, "rotation_degrees.y", 0.1, move_wait_time)
	tween.tween_property(self, "position", state_to_be, move_wait_time)
	go_back_button.show()
	can_turn = false

func update_look_side(turn_dir: int) -> void:
	current_look_dir_index = (current_look_dir_index + turn_dir) % look_directions.size()
	current_look_dir_name = look_directions[current_look_dir_index]
	looking_dir.emit(current_look_dir_name)

func create_my_tween() -> Tween:
	return create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_go_back_button_pressed() -> void:
	var tween: Tween = create_my_tween()
	#tween.set_parallel()
	#tween.tween_property(self, "rotation:y", 0.1, move_wait_time)
	tween.tween_property(self, "position", previous_position, move_wait_time)
	go_back_button.hide()
	can_turn = true
