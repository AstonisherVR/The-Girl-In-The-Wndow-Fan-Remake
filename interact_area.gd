class_name CloseUpArea extends Area3D
signal player_close_up(where_to: Vector3)
signal disable_collisions
var mouse_in: bool = false
@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@export_enum("COAT_RACK", "LIGHT_SWITCH", "FLOOR_PLANK", "DRAWER", "PIPE", "TV", "VCR",
			"POWER_CABLE", "UPER_SHELF_CABINET", "LOWER_SHELF_CABINET", "BOOKS",
			"NUMBERS_PUZZLE_BOX", "SYMBOLS_PUZZLE_CABINET", "FIGURE_PUZZLE_CABINET",
			"VAMPIRE", "MOUSE", "PLANT_WITH_STONE", "COUCH", "FAKE_PLUG", "NEWS",
			"TABLE", "WINDOW", "DRAWER_WITH_PHOTO") var my_close_up_name: String
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L_CLICK") and mouse_in == true: interact()

func interact() -> void:
	player_close_up.emit(close_up_state_positions[my_close_up_name])
	disable_collisions.emit()

func reset() -> void:
	collision_shape.disabled = false

func _on_mouse_entered() -> void: mouse_in = true

func _on_mouse_exited() -> void: mouse_in = false
