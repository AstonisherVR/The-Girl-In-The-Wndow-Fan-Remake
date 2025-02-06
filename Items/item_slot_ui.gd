class_name ItemSlotUI extends Button

@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")
@onready var center_container: CenterContainer = %CenterContainer

var my_child_item_ui: ItemUI
var my_index_in_inventory_ui: int

## This displays what item is seen in the slot
func insert_item_to_ui_slot(item_to_insert: ItemUI) -> void:
	my_child_item_ui = item_to_insert
	center_container.add_child(my_child_item_ui)

	if !my_child_item_ui.item_data or player_inventory.item_data_list[my_index_in_inventory_ui] == my_child_item_ui.item_data: return
	player_inventory.insert_item_data_at_index(my_child_item_ui.item_data, my_index_in_inventory_ui)

## Removes the item that was being displayed
func remove_item_ui() -> void:
	center_container.remove_child(my_child_item_ui)
	my_child_item_ui = null

## A check to see if the slot is empty
func is_slot_empty() -> bool:
	return !my_child_item_ui
