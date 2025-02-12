class_name BaseInteractable extends Area3D

@onready var player_inventory: InventoryResource = preload("uid://bwv3dsew20e5h")

@export var item_name_to_interact_with: StringName
@export var removable: bool = false

var mouse_in: bool = false
var have_been_used: bool = false

func _input(event: InputEvent) -> void:
	if have_been_used: return
	if !InventoryUI.currently_selected_ui_item: return
	if event.is_action_pressed("L_CLICK") and mouse_in == true:
		if InventoryUI.currently_selected_ui_item.item_data.name == item_name_to_interact_with:
			interact_with_item(InventoryUI.currently_selected_ui_item.item_data)
			if removable: remove_self()
			else: have_been_used = true

func interact_with_item(item_to_interact: ItemResource) -> void:
	player_inventory.use_item(item_to_interact)

func remove_self() -> void:
	queue_free()

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
