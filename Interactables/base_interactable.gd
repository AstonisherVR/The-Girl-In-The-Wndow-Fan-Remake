class_name BaseInteractable extends Area3D
## Interactables are objects that can be interacted with while holding an item.
## They return another item, combine with
@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")

@export var item_name_to_interact_with: StringName
@export var removable: bool = false

var have_been_used: bool = false

func _on_click_component_clicked() -> void:
	if have_been_used: return
	if not InventoryUI.currently_selected_ui_item: return
	interact_with_currently_selected_item()

func interact_with_currently_selected_item() -> void:
	if InventoryUI.currently_selected_ui_item.item_data.name == item_name_to_interact_with:
		player_inventory.use_item(InventoryUI.currently_selected_ui_item.item_data)
		if removable: queue_free()
		else: have_been_used = true
