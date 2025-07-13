extends Node3D
signal solved

@onready var puzz_buts: Array[PuzzleButton] = [%"Puzz But1", %"Puzz But2",
												%"Puzz But3", %"Puzz But4"]

var possib_symbs: Array[StringName] = [
	&"Star", &"Crown", &"Waves", &"Moon", &"Sunset",
	&"Triangles", &"Pie", &"Sun", &"Wind", &"Leaf"]

var symbols_of_buts: Dictionary[StringName, StringName] = {
	&"Puzz But1": possib_symbs[0], &"Puzz But2": possib_symbs[0],
	&"Puzz But3": possib_symbs[0], &"Puzz But4": possib_symbs[0] }

var PASSWORD: Array[StringName] = [
	possib_symbs.pick_random(), possib_symbs.pick_random(),
	possib_symbs.pick_random(), possib_symbs.pick_random()]

func _ready() -> void:
	_generate_password()
	for puzz_but: PuzzleButton in puzz_buts:
		puzz_but.button_clicked.connect(_on_puzz_but_clicked.bind(puzz_but.name))
		#puzz_but.change_symbol_text(buttons_symbols[puzz_but.name])

	print(&"symb pass: ", PASSWORD)

func _generate_password() -> void:
	while true:
		if PASSWORD[1] == PASSWORD[0]:
			PASSWORD[1] = possib_symbs.pick_random()
			continue
		if PASSWORD[2] == PASSWORD[1] or PASSWORD[2] == PASSWORD[0]:
			PASSWORD[2] = possib_symbs.pick_random()
			continue
		if PASSWORD[3] == PASSWORD[2] or PASSWORD[3] == PASSWORD[1] or PASSWORD[3] == PASSWORD[0]:
			PASSWORD[3] = possib_symbs.pick_random()
			continue
		break

func _on_puzz_but_clicked(but_clicked_name: StringName) -> void:
	# Get the current symbol index in possib_symbs
	var current_symbol: StringName = symbols_of_buts[but_clicked_name]
	var current_index: int = possib_symbs.find(current_symbol)

	# Change the Data of the symbol name, wrapping around if needed
	var next_index: int = (current_index + 1) % possib_symbs.size()
	symbols_of_buts[but_clicked_name] = possib_symbs[next_index]

	# Update the visuals of the symbol button
	for puzz_but: PuzzleButton in puzz_buts: puzz_but.change_symbol(symbols_of_buts[puzz_but.name])
	check_for_win()

func check_for_win() -> void:
	if symbols_of_buts.values() == PASSWORD:
		solved.emit()
		for puzz_but: PuzzleButton in puzz_buts: puzz_but.disable_collision_shape()
		print(&"symb puzz solved")
