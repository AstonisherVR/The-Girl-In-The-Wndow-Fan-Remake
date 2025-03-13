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
	"UPER_SHELF_CABINET": Vector3(2, 1.8, 2.4),
	"LOWER_SHELF_CABINET": Vector3(2, -.5, 2.5),
	"BOOKS": 			Vector3(0, 0, 0),
	"NUMBERS_PUZZLE_BOX": Vector3(0, 0, 0),
	"SYMBOLS_PUZZLE_CABINET": Vector3(0, 0, 0),
	"FIGURE_PUZZLE_CABINET": Vector3(0, 0, 0),
	"VAMPIRE": 			Vector3(0, 0, 0),
	"MOUSE": 			Vector3(0, 0, 0),
	"PLANT_WITH_STLEFT": Vector3(0, 0, 0),
	"COUCH": 			Vector3(0, 0, 0),
	"FAKE_PLUG": 		Vector3(0, 0, 0),
	"NEWS": 			Vector3(0, 0, 0),
	"TABLE": 			Vector3(0, 0, 0),
	"WINDOW": 			Vector3(0, 0, 0),
	"DRAWER_WITH_PHOTO": Vector3(0, 0, 0),
	}

func _on_click_component_clicked() -> void:
	interact()

func interact() -> void:
	player_close_up.emit(close_up_state_positions[my_close_up_name])
	disable_collisions.emit()
