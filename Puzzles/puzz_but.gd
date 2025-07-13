class_name PuzzleButton extends Area3D
signal button_clicked

@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@onready var number_text_mesh: TextMesh = (%NumberMesh as MeshInstance3D).mesh as TextMesh
@onready var symb_sprite: Sprite3D = %Sprite3D

@onready var number_mesh: MeshInstance3D = %NumberMesh
@onready var symbol_mesh: MeshInstance3D = %SymbolMesh

@export_enum("Number_Button", "Symbol_Button") var button_type: String = "Number_Button"

var symbols: Dictionary[StringName, int] = {
	&"Star":	0,
	&"Crown":	1,
	&"Waves":	2,
	&"Moon":	3,
	&"Sunset":	4,
	&"Triangles":5,
	&"Pie":		6,
	&"Sun":		7,
	&"Wind":	8,
	&"Leaf":	9

}
var possib_symbs: Array[StringName] = [
	&"Star", &"Crown", &"Waves", &"Moon", &"Sunset",
	&"Triangles", &"Pie", &"Sun", &"Wind", &"Leaf"]

func _ready() -> void:
	if button_type == "Number_Button":
		symbol_mesh.hide()
		number_mesh.show()
	else:
		symbol_mesh.show()
		number_mesh.hide()

func _on_click_component_clicked() -> void:
	button_clicked.emit()

func disable_collision_shape() -> void:
	collision_shape.disabled = true

func change_num_text(number: int) -> void:
	number_text_mesh.text = str(number)

func change_symbol(symbol_name: String) -> void:
	symb_sprite.frame = symbols[symbol_name]
	#TODO Make the symbols
