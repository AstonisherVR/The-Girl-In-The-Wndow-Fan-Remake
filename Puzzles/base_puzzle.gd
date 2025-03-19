extends Node3D
signal solved

@onready var puzz_buts: Array[PuzzleButton] = [%"Puzz But1", %"Puzz But2", %"Puzz But3", %"Puzz But4"]

var possib_nums: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var PASSWORD: Array[int] = [possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random()]

var buttons_numbers: Dictionary[StringName, int] = {
	&"Puzz But1": possib_nums.pick_random(),
	&"Puzz But2": possib_nums.pick_random(),
	&"Puzz But3": possib_nums.pick_random(),
	&"Puzz But4": possib_nums.pick_random(),
}

func _ready() -> void:
	while buttons_numbers.values() == PASSWORD:
		for button_name: StringName in buttons_numbers:
			buttons_numbers[button_name] = possib_nums.pick_random()
	for puzz_but: PuzzleButton in puzz_buts:
		puzz_but.button_clicked.connect(_on_puzz_but_clicked.bind(puzz_but.name))
		puzz_but.change_text(buttons_numbers[puzz_but.name])

	print("num pass: ", PASSWORD)

func _on_puzz_but_clicked(button_clicked_name: StringName) -> void:
	buttons_numbers[button_clicked_name] = wrapi(buttons_numbers[button_clicked_name] + 1, 1, 10)
	for puzz_but: PuzzleButton in puzz_buts: puzz_but.change_text(buttons_numbers[puzz_but.name])
	if buttons_numbers.values() == PASSWORD:
		solved.emit()
		for puzz_but: PuzzleButton in puzz_buts: puzz_but.disable_collision_shape()
		print("num puzz solved")
