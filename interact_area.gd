extends Area3D

var mouse_in: bool = false
@onready var go_to_pos: Vector3 = position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L_CLICK") and mouse_in == true:
		pass

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
