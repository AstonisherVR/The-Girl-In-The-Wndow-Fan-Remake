class_name InventoryResource extends Resource

## When the data of the inventory gets changed, a signal is being emitted.
## Then the Inventory UI updates itself when it recives the signal, based on the new information in the Player Inventory
signal items_updated

#signal use_item

## A list of the data for the items in the player inventory. 14 by defult.
@export var inventory_items: Array[ItemResource] = [null, null, null, null, null, null, null,
													null, null, null, null, null, null, null,]

func insert_item_data_at_first_empty_slot(collected_item: ItemResource) -> void:
	for index in range(inventory_items.size()):
		if !inventory_items[index]:
			inventory_items[index] = collected_item
			break
	items_updated.emit()

func remove_item_data_at_index(index: int) -> void:
	inventory_items[index] = ItemResource.new()

func insert_item_data_at_index(item_to_insert: ItemResource, index: int) -> void:
	var old_index: int = inventory_items.find(item_to_insert)
	remove_item_data_at_index(old_index)
	inventory_items[index] = item_to_insert

#func use_item_at_index(index: int) -> void:
	#if index < 0 or index >= inventory_items.size() or !items[index]: return
	#var item: ItemResource = items[index]
	#use_item.emit()

#func combine_items(first_item_index: int, second_item_index: int) -> void:
	##TODO Make Items Return what they are supossed to
	#var combined_item: ItemResource = null
	#items[second_item_index] = null
	#items[first_item_index] = combined_item
	#items_updated.emit()
#
#func remove_item(item_index: int) -> ItemResource:
	#var previous_item: ItemResource = items[item_index]
	#items[item_index] = null
	#items_updated.emit()
	#return previous_item
