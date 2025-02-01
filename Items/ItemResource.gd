class_name ItemResource extends Resource

@export var name: String
@export var texture: Texture

func get_possible_combination() -> String:
	for combinable_item in Global.COMBINABLE_ITEMS:
		if name == combinable_item:
			print(combinable_item)
	return ""
#@export var model: Mesh
