extends Node3D
signal solved

@onready var collision_shapes: Dictionary[StringName, CollisionShape3D] = {
	&"B1": %"B1CollisionShape3D",
	&"B2": %"B2CollisionShape3D",
	&"B3": %"B3CollisionShape3D",
	&"B4": %"B4CollisionShape3D" }

var possib_nums: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var PASSWORD: Array[int] = [possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random()]
var buttons_numbers: Dictionary[StringName, int] = {
	&"B1": possib_nums.pick_random(),
	&"B2": possib_nums.pick_random(),
	&"B3": possib_nums.pick_random(),
	&"B4": possib_nums.pick_random(),
}

func _ready() -> void:
	while buttons_numbers.values() == PASSWORD:
		for button_name: StringName in buttons_numbers:
			buttons_numbers[button_name] = possib_nums.pick_random()
	for child: Node in get_children():
		if child is not Area3D: continue
		for child2: Node in child.get_children():
			if child2 is ClickComponent:
				(child2 as ClickComponent).clicked.connect(_on_click_component_clicked.bind((child2 as ClickComponent).parent.name))
			else: print(child2)
	print(PASSWORD)

func _on_click_component_clicked(button_clicked_name: StringName) -> void:
	print(button_clicked_name)
	buttons_numbers[button_clicked_name] = wrapi(buttons_numbers[button_clicked_name] + 1, 1, 10)
	for button_name: StringName in buttons_numbers: print(button_name,": ", buttons_numbers[button_name])
	if buttons_numbers.values() == PASSWORD:
		for collision_shape: CollisionShape3D in collision_shapes.values(): collision_shape.disabled = true
		solved.emit()
		print("solved")
