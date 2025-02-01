class_name ItemUI extends TextureRect

var minimum_size: Vector2 = Vector2(160.0, 160.0)
var item_data: ItemResource

func update_ui_item() -> void:
	texture = item_data.texture if item_data else null

func _init() -> void:
	set_stretch_mode(STRETCH_KEEP_CENTERED)
	set_custom_minimum_size(minimum_size)
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

#func combine_with(item: ItemUI) -> ItemUI:
	#update_ui_item()
	#return null
