class_name CloseUpArea extends Area3D

signal player_close_up(where_to: Vector3)
signal disable_collisions

@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@export_enum("COAT_RACK", "LIGHT_SWITCH", "FLOOR_PLANK", "DRAWER", "PIPE", "TV", "VCR",
			"POWER_CABLE", "UPER_SHELF_CABINET", "LOWER_SHELF_CABINET", "BOOKS",
			"NUMBERS_PUZZLE_BOX", "SYMBOLS_PUZZLE_CABINET", "FIGURE_PUZZLE_CABINET",
			"VAMPIRE", "MOUSE", "PLANT_WITH_STONE", "COUCH", "FAKE_PLUG", "NEWS",
			"TABLE", "WINDOW", "DRAWER_WITH_PHOTO") var my_close_up_name: String

var close_up_state_positions: Dictionary[String, Vector3] = {
	"CENTER_OF_ROOM": 	Vector3.ZERO,
	"COAT_RACK":		Vector3(-2.3, 1.3, -2.1),
	"LIGHT_SWITCH": 	Vector3(-1.25, .6, -2.75),
	"FLOOR_PLANK": 		Vector3(-3, -.5, -1),
	"DRAWER": 			Vector3(2.2, .4, -1),
	"PIPE": 			Vector3(3.1, -.5, -3),
	"TV":				Vector3(2, 0.55, -.25),
	"VCR": 				Vector3(2, -.2, -.2),
	"POWER_CABLE": 		Vector3(2.8, -.55, .55),
	"UPER_SHELF_CABINET":	Vector3(2, 1.8, 2.4),
	"LOWER_SHELF_CABINET": 	Vector3(2, -.4, 2.5),
	"BOOKS": 				Vector3(2.1, 1.619, 1.667),
	"NUMBERS_PUZZLE_BOX": 	Vector3(2.27, .32, 2.47),
	"SYMBOLS_PUZZLE_CABINET": Vector3(2.35, -.6, 2),
	"FIGURE_PUZZLE_CABINET": Vector3(1.2, -.5, 2),
	"VAMPIRE": 			Vector3(-2., 1, 3),
	"MOUSE": 			Vector3(-1.6, -.7, 2.8),
	"PLANT_WITH_STONE": Vector3(-2.9, -.1, 3.1),
	"COUCH": 			Vector3(-3.4, 0, 2),
	"FAKE_PLUG": 		Vector3(-3.5, -.6, 2.6),
	"NEWS": 			Vector3(-3.5, 1, .7),
	"TABLE": 			Vector3(-3.4, 0.1, 0.4),
	"WINDOW": 			Vector3(-3.59, 1, -2.064),
	"DRAWER_WITH_PHOTO": Vector3(-3.3, 0, -2.022),
	}

func _on_click_component_clicked() -> void:
	player_close_up.emit(close_up_state_positions[my_close_up_name])
	disable_collisions.emit()
