class_name ItemUI extends TextureRect

var item_data: ItemResource

# Initializes with the correct parameters
func _init() -> void:
	set_stretch_mode(STRETCH_KEEP_CENTERED)
	set_custom_minimum_size(Vector2(160.0, 160.0))
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

## Matches its texture to the item data
func update_ui_item() -> void:
	texture = item_data.texture if item_data else null
