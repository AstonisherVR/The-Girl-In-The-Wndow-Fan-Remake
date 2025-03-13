class_name ClickComponent extends Node
signal clicked

var mouse_in: bool = false
@onready var parent: Area3D = get_parent() as Area3D

func _ready() -> void:
	if parent is Area3D:
		parent.mouse_entered.connect(_on_mouse_entered)
		parent.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L_CLICK") and mouse_in:
		clicked.emit()
