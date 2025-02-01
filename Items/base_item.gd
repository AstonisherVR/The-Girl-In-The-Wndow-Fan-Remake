class_name BaseItem extends Area3D

var mouse_in: bool = false

@export var item_data: ItemResource
@onready var player_inventory: InventoryResource = preload("res://Inventory/Player_Inventory_Data.tres")

## When an item gets collected, the inventory data changes directly
func collect_item() -> void:
	player_inventory.insert_item_data_at_first_empty_slot(item_data)
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L_CLICK") and mouse_in == true:
		collect_item()

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
