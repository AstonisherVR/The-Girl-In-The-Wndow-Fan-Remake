extends Panel

const player_inventory = preload("uid://bwv3dsew20e5h")
@onready var inventory_ui: InventoryUI = $"../Inventory UI"
@onready var selected_item_label: Label = $"Current Selected Item"
@onready var player_inventory_data: Label = $"Player Inventory Data"

func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if inventory_ui.currently_selected_ui_item:
			var ui_sel_it := inventory_ui.currently_selected_ui_item
			var itm_name: String = ui_sel_it.item_data.name
			selected_item_label.text = "Selected Item "+ itm_name
		else:
			selected_item_label.text = "No Item Selected"
		player_inventory_data.text = str(player_inventory.item_data_list)
