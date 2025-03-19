class_name PuzzleButton extends Area3D
signal button_clicked

@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@onready var number_mesh: TextMesh = (%NumberMesh as MeshInstance3D).mesh as TextMesh

func _on_click_component_clicked() -> void:
	button_clicked.emit()

func disable_collision_shape() -> void:
	collision_shape.disabled = true

func change_text(number: int) -> void:
	number_mesh.text = str(number)
