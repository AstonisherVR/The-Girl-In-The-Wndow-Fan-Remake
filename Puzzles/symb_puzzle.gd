extends Node3D
signal solved

@onready var puzz_buts: Array[PuzzleButton] = [%"Puzz But1", %"Puzz But2", %"Puzz But3", %"Puzz But4"]

var possib_symbs: Array[String] = ["Something", "Something2", "Something3"]
var PASSWORD: Array[String] = [possib_symbs.pick_random(), possib_symbs.pick_random(), possib_symbs.pick_random(), possib_symbs.pick_random()]

var buttons_symbols: Dictionary[StringName, StringName] = {
	&"Puzz But1": possib_symbs.pick_random(),
	&"Puzz But2": possib_symbs.pick_random(),
	&"Puzz But3": possib_symbs.pick_random(),
	&"Puzz But4": possib_symbs.pick_random() }

# TODO Make a global Debugger
func _ready() -> void: print("symb pass: ", PASSWORD)

func _on_puzz_but_clicked() -> void:
	if buttons_symbols.values() == PASSWORD: solved.emit()
	print("symb puzz solved")
