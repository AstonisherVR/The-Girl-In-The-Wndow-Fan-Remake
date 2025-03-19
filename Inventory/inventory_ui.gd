class_name InventoryUI extends NinePatchRect

## References to the player's inventory data
@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")
@onready var ui_item_slots: Array[Node] = %"HBox Items Container".get_children()

## Tracks the currently selected UI item. ItemUI is a TextureRect
static var currently_selected_ui_item: ItemUI

func _ready() -> void:
	connect_signals()
	update_item_ui_to_match_item_data()

## Connects the signals from the player inventory and the item slots
func connect_signals() -> void:
	# Connects the items_updated signal to update the UI
	player_inventory.items_updated.connect(update_item_ui_to_match_item_data)

	# Connect each UI slot to handle clicks
	for item_slot_ui_index: int in range(ui_item_slots.size()):
		var item_slot_ui: ItemSlotUI = ui_item_slots[item_slot_ui_index] as ItemSlotUI
		item_slot_ui.my_index_in_inventory_ui = item_slot_ui_index
		item_slot_ui.pressed.connect(_on_slot_clicked.bind(item_slot_ui))

## Handles what happends when a slot gets pressed
func _on_slot_clicked(item_slot_ui: ItemSlotUI) -> void:
	# If the slot is empty and an item has been selected, it should deselect, if not then it returns
	if item_slot_ui.is_slot_empty():
		if currently_selected_ui_item:
			_deselect_item()
		return

	# But If the slot is NOT empty
	# If the player hasn't selected any items, select the item from the slot
	if not currently_selected_ui_item:
		_select_item(item_slot_ui)
	# If the player has selected an item and the item is the same as the item in the slot, deselect it
	elif currently_selected_ui_item == item_slot_ui.my_child_item_ui:
		_deselect_item()
	# If the player item and the selected item can combine, combine them and select the new item
	elif currently_selected_ui_item.item_data.can_combine_with_item and item_slot_ui.my_child_item_ui.item_data.can_combine_with_item:
		_combine_item(item_slot_ui)
		_select_item(item_slot_ui)
	# Otherwise, select the new item
	else: _select_item(item_slot_ui)

## Selects an item from a slot
func _select_item(item_slot_ui: ItemSlotUI) -> void:
	currently_selected_ui_item = item_slot_ui.my_child_item_ui

## Deselects the current item
func _deselect_item() -> void:
	currently_selected_ui_item = null

func _combine_item(selected_slot: ItemSlotUI) -> void:
	player_inventory.combine_items(currently_selected_ui_item.item_data, selected_slot.my_child_item_ui.item_data)

## Updates the UI to match the item data
func update_item_ui_to_match_item_data() -> void:
	# Checks if the number of items in the player's inventory matches the number of UI slots
	if player_inventory.item_data_list.size() != ui_item_slots.size():
	# If the inventory size doesn't match the number of UI slots, will throw an error and debug information
		push_error("PLAYER INVENTORY SIZE DOESN'T MATCH THE NUMBER OF UI SLOTS")
		print_debug("Player Inventory Size: ", player_inventory.item_data_list.size(),
					"\nNumber of UI Slots: ", ui_item_slots.size())
		return

	# Updates each UI slot with the corresponding inventory item
	for index: int in range(player_inventory.item_data_list.size()):
		# Gets the current item data of the iteration from the player's inventory items
		var current_item_data: ItemResource = player_inventory.item_data_list[index]
		# Gets the current slot UI of the iteration
		var current_item_slot_ui: ItemSlotUI = (ui_item_slots[index] as ItemSlotUI)
		# Gets the current item UI of the iteration from the slot
		var current_item_ui: ItemUI = current_item_slot_ui.my_child_item_ui

		# Will skip this iteration if the item data is null
		if not current_item_data:
			# Will also remove the displayed item if the data is null
			if current_item_ui:
				current_item_slot_ui.remove_item_ui()
			continue

		# If there's no UI for the item, a new ItemUI gets created
		if not current_item_ui:
			current_item_ui = ItemUI.new()
			current_item_slot_ui.insert_item_to_ui_slot(current_item_ui)

		# Matches the item data to the item UI
		current_item_ui.item_data = current_item_data
		current_item_ui.update_ui_item()
