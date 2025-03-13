class_name BaseItem extends Area3D

signal disable_all_items_collision

@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")
@onready var collision_shape: CollisionShape3D = %CollisionShape3D
@export var item_data: ItemResource

func _ready() -> void:
	if item_data: item_data.name = name
	disable_all_items_collision.emit.call_deferred()

func _on_click_component_clicked() -> void:
	collect_item()

## When an item gets collected, the inventory data changes directly
func collect_item() -> void:
	player_inventory.insert_item_data_at_first_empty_slot(item_data)
	queue_free()
