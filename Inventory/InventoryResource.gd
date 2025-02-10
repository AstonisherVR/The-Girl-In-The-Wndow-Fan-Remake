class_name InventoryResource extends Resource

## When the data of the inventory gets changed, a signal is being emitted.
## Then the Inventory UI updates itself when it recives the signal, based on the new information in the Player Inventory
signal items_updated

## A list of the data for the items in the player inventory. 14 by defult.
@export var item_data_list: Array[ItemResource] = [null, null, null, null, null, null, null,
													null, null, null, null, null, null, null,]

# Dictionary to store all valid combinations and their results
# Format: {"ItemName1 + ItemName2": "ResultItemPath"}
const POSSIBLE_COMBINATIONS: Dictionary[StringName, StringName] = {
	&"Candle + Defult": &"uid://dgtexkmoux711",
	&"Floor Plank + Defult": &"uid://dgtexkmoux711",
	# Add more combinations
}

# Use item_combinations.combinations in your combine_items function
#@onready var possible_item_combinations: ItemCombinations = preload("res://path_to/ItemCombinations.gd")

func insert_item_data_at_first_empty_slot(collected_item: ItemResource) -> void:
	for index in range(item_data_list.size()):
		#print(item_data_list)
		# If it's empty, add the item data
		if !item_data_list[index]:
			item_data_list[index] = collected_item
			break
	items_updated.emit()

func remove_item_data(item_data_to_remove: ItemResource) -> void:
	var index: int = item_data_list.find(item_data_to_remove)
	if index < 0: return
	item_data_list[index] = null

func insert_item_data_at_index(item_data_to_insert: ItemResource, index: int) -> void:
	item_data_list[index] = item_data_to_insert

func remove_item_data_at_index(index: int) -> void:
	item_data_list[index] = null

func use_item(use_item_data: ItemResource) -> void:
	remove_item_data(use_item_data)
	items_updated.emit()

func combine_items(item_1: ItemResource, item_2: ItemResource) -> void:
	# Creates the two posible combination keys
	var combo_key1: StringName = StringName("%s + %s" % [item_1.name, item_2.name])
	var combo_key2: StringName = StringName("%s + %s" % [item_2.name, item_1.name])
	var result_path: String
	# Check for valid combinations, in case the order of selected and the second items are reversed
	if POSSIBLE_COMBINATIONS.has(combo_key1):
		result_path = POSSIBLE_COMBINATIONS[combo_key1]
	elif POSSIBLE_COMBINATIONS.has(combo_key2):
		result_path = POSSIBLE_COMBINATIONS[combo_key2]
	else:
		return  # These items can combine but, No valid combination found
	# Load the resulting item data
	var combined_item_data: ItemResource = load(result_path) as ItemResource
	# Find the indexes if the items
	var index_of_item_1: int = item_data_list.find(item_1)
	var index_of_item_2: int = item_data_list.find(item_2)
	# Remove the original items from the list data
	remove_item_data_at_index(index_of_item_1)
	remove_item_data_at_index(index_of_item_2)
	# Add the new combined item
	insert_item_data_at_index(combined_item_data, index_of_item_2)
	items_updated.emit()


# WARNING This is important OLD code from the tutorial
#func remove_item_data_at_index(index: int) -> void:
	#item_data_list[index] = null
	#items_updated.emit()
#func insert_item_data_at_index(item_data_to_insert: ItemResource, index: int) -> void:
	#var old_index: int = item_data_list.find(item_data_to_insert)
	#if old_index != -1:
		#remove_item_data_at_index(old_index)
	#item_data_list[index] = item_data_to_insert
	#items_updated.emit()
