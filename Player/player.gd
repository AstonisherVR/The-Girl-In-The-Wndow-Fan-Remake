class_name Player extends Node3D

@onready var inventory: InventoryResource = preload("res://Player/Player_Inventory_Data.tres")
@onready var go_back_button: TextureButton = %"Go Back Button"
@export var rotation_duration: float = 0.2	# Seconds

var current_rotation: float
var previous_position: Vector3
var can_turn: bool = true

func _ready() -> void:
	go_back_button.hide()

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

func player_look_at(state_to_be: Vector3) -> void:
	previous_position = position
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.set_parallel()
	#tween.tween_property(self, "rotation:y", 0.1, rotation_duration)
	tween.tween_property(self, "position", state_to_be, rotation_duration)
	go_back_button.show()
	can_turn = false

func _on_go_back_button_pressed() -> void:
	var tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.set_parallel()
	#tween.tween_property(self, "rotation:y", 0.1, rotation_duration)
	tween.tween_property(self, "position", previous_position, rotation_duration)
	go_back_button.hide()
	can_turn = true
