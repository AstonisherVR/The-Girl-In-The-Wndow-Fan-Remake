extends Node3D
signal solved

@onready var puzz_buts: Array[PuzzleButton] = [%"Puzz But1", %"Puzz But2",
												%"Puzz But3", %"Puzz But4"]

var possib_nums: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

var numbers_of_buts: Dictionary[StringName, int] = {
	&"Puzz But1": possib_nums[0], &"Puzz But2": possib_nums[0],
	&"Puzz But3": possib_nums[0], &"Puzz But4": possib_nums[0], }

var PASSWORD: Array[int] = [possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random(), possib_nums.pick_random()]

func _ready() -> void:
	for puzz_but: PuzzleButton in puzz_buts:
		puzz_but.button_clicked.connect(_on_puzz_but_clicked.bind(puzz_but.name))
	print("num pass: ", PASSWORD)

func _on_puzz_but_clicked(but_clicked_name: StringName) -> void:
	numbers_of_buts[but_clicked_name] = wrapi(numbers_of_buts[but_clicked_name] + 1, 1, 10)
	for puzz_but: PuzzleButton in puzz_buts: puzz_but.change_num_text(numbers_of_buts[puzz_but.name])
	check_for_win()

func check_for_win() -> void:
	if numbers_of_buts.values() == PASSWORD:
		solved.emit()
		for puzz_but: PuzzleButton in puzz_buts: puzz_but.disable_collision_shape()
		print(&"num puzz solved")
