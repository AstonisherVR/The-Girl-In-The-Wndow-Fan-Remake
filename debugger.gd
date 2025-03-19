extends CanvasLayer

const player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")
@onready var inventory_ui: InventoryUI = $"../UI/Inventory UI"
@onready var slcted_itm_label: Label = $"Current Selected Item"
@onready var player_inv_data_label: Label = $"Player Inventory Data"

func _ready() -> void:
	if not OS.is_debug_build(): queue_free()
	player_inventory.items_updated.connect(update_debug_display)
	update_debug_display()

func _input(_event: InputEvent) -> void:
	update_selected_itm()

func update_debug_display() -> void:
	# Updates the items
	var inv_text: String = ""
	for item: Variant in player_inventory.item_data_list:
		if !item:
			inv_text += "<null>, "
			continue
		inv_text += item.name + ", "
	player_inv_data_label.text = inv_text

	# Updates something else
	pass

func update_selected_itm() -> void:
	if inventory_ui.currently_selected_ui_item:
		var ui_slcted_itm: ItemUI = inventory_ui.currently_selected_ui_item
		var itm_name: String = ui_slcted_itm.item_data.name
		slcted_itm_label.text = "Selected Item "+ itm_name
	else: slcted_itm_label.text = "No Item Selected"
