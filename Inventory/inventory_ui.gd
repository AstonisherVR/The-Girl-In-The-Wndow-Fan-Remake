class_name InventoryUI extends NinePatchRect

## References to the player's inventory data
@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")
@onready var ui_item_slots: Array[Node] = %"HBox Items Container".get_children()

## Tracks the currently selected UI item TextureRect
var currently_selected_ui_item: ItemUI

func _ready() -> void:
	connect_signals()
	update_item_ui_to_match_item_data()

## Connects the signals from the player inventory and the item slots
func connect_signals() -> void:
	# Connects the items_updated signal to update the UI
	player_inventory.items_updated.connect(update_item_ui_to_match_item_data)

	# Connect each UI slot to handle clicks
	for ui_slot_index: int in range(ui_item_slots.size()):
		var ui_slot: ItemSlotUI = ui_item_slots[ui_slot_index] as ItemSlotUI
		ui_slot.my_index_in_inventory_ui = ui_slot_index
		ui_slot.pressed.connect(_on_slot_clicked.bind(ui_slot))

## Handles what happends when a slot gets pressed
func _on_slot_clicked(ui_slot: ItemSlotUI) -> void:
# If the slot is empty
	if ui_slot.is_slot_empty():
		# If an item has been selected, it should deselect
		if currently_selected_ui_item:
			_deselect_item()
			return
		return
# But if the slot is not empty:
	# If the player hasn't selected any items
	# the item from the slot gets asigned as the currently selected item
	if !currently_selected_ui_item:
		_select_item(ui_slot)
		return

	# If the player has selected an item, and the selected item is the same as the item in the slot, it should get deselected
	elif currently_selected_ui_item == ui_slot.my_child_item_ui:
		_deselect_item()
	# If the player has selected an item, and there is another item in the slot, it should get selected
	else:
		_select_item(ui_slot)
	# If non of these are true, then nothing happends

## Selects an item from a slot
func _select_item(ui_slot: ItemSlotUI) -> void:
	currently_selected_ui_item = ui_slot.my_child_item_ui

## Deselects the current item
func _deselect_item() -> void:
	currently_selected_ui_item = null

## Inserts an item into a slot
#func _insert_item_in_slot(ui_slot: ItemSlotUI) -> void:
	#var selected_item_ui: ItemUI = currently_selected_ui_item
	##remove_child(currently_selected_ui_item)
	#currently_selected_ui_item = null
	#ui_slot.insert_item_in_slot(selected_item_ui)
#
#func _combine_items(selected_slot_ui: ItemSlotUI) -> void:
	## Reference to the item UI that was clicked
	#var selected_item_ui: ItemUI = selected_slot_ui.my_child_item_ui
	## TODO Create the result from the combined items
	#var result_item: ItemUI = selected_item_ui.combine_with(currently_selected_ui_item)

#func update_selected_ui_item_pos(previous_item_pos: Vector2) -> void:
	#if currently_selected_ui_item:
		#currently_selected_ui_item.global_position = previous_item_pos

## Updates the UI to match the item data
func update_item_ui_to_match_item_data() -> void:
	# Checks if the number of items in the player's inventory matches the number of UI slots
	if player_inventory.inventory_items.size() != ui_item_slots.size():
	# If the inventory size doesn't match the number of UI slots, will throw an error and debug information
		push_error("PLAYER INVENTORY SIZE DOESN'T MATCH THE NUMBER OF UI SLOTS")
		print_debug("Player Inventory Size: ", player_inventory.inventory_items.size(),
					"\nNumber of UI Slots: ", ui_item_slots.size())
		return

	# Updates each UI slot with the corresponding inventory item
	for index: int in range(player_inventory.inventory_items.size()):
		# Gets the data of the current item of the iteration from the player's inventory
		var current_item_data: ItemResource = player_inventory.inventory_items[index]
		# Will skip this iteration if the item data is null or invalid
		if not current_item_data: continue
		# Gets the item UI of the current slot
		var current_item_ui: ItemUI = (ui_item_slots[index] as ItemSlotUI).my_child_item_ui
		# If the item UI is null or invalid, a new ItemUI gets created and insert it into the slot
		if not current_item_ui:
			current_item_ui = ItemUI.new()
			(ui_item_slots[index] as ItemSlotUI).insert_item_to_ui_slot(current_item_ui)
		# Matches the item data to the item UI
		current_item_ui.item_data = current_item_data
		current_item_ui.update_ui_item()
