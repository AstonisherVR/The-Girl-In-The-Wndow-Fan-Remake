class_name InteractArea extends Area3D
signal player_close_up(where_to: String)

@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@export_enum("CENTER_OF_ROOM", "COAT_RACK", "LIGHT_SWITCH", "FLOOR_PLANK", "DRAWER", "PIPE", "TV", "VCR",
			"POWER_CABLE", "UPER_SHELF_CABINET", "LOWER_SHELF_CABINET", "BOOKS", "NUMBERS_PUZZLE_BOX",
			"SYMBOLS_PUZZLE_CABINET", "FIGURE_PUZZLE_CABINET", "VAMPIRE", "MOUSE", "PLANT_WITH_STONE",
			"COUCH", "FAKE_PLUG", "NEWS", "TABLE", "WINDOW", "DRAWER_WITH_PHOTO") var my_close_up: String

var mouse_in: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L_CLICK") and mouse_in == true:
		player_close_up.emit(my_close_up)
		collision_shape.disabled = true

func _on_mouse_entered() -> void:
	mouse_in = true
func _on_mouse_exited() -> void:
	mouse_in = false
