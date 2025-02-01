class_name ItemSlotUI extends Button

@onready var player_inventory: InventoryResource = preload("res://Inventory/Player_Inventory_Data.tres")
@onready var center_container: CenterContainer = %CenterContainer

var my_child_item_ui: ItemUI
var my_index_in_inventory_ui: int

func insert_item_to_ui_slot(item_to_insert: ItemUI) -> void:
	if my_child_item_ui == item_to_insert:
		center_container.remove_child(my_child_item_ui)
	my_child_item_ui = item_to_insert
	center_container.add_child(my_child_item_ui)

	if !my_child_item_ui.item_data or player_inventory.inventory_items[my_index_in_inventory_ui] == my_child_item_ui.item_data: return
	player_inventory.insert_item_data_at_index(my_child_item_ui.item_data, my_index_in_inventory_ui)

#func select_item_in_slot() -> ItemUI:
	#var selected_item: ItemUI = my_child_item_ui
	#my_child_item_ui = null
	#return selected_item

func is_slot_empty() -> bool:
	return !my_child_item_ui
