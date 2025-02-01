extends Node3D

@export var inventory: InventoryResource
#@onready var player_inventory: InventoryResource = preload("res://Inventory/Player_Inventory_Data.tres")

var is_turning: bool = false
var rotation_speed: float = 9.0

#func _process(delta: float) -> void:
	#pass

func _input(event: InputEvent) -> void:
	turn(event)

func turn(event: InputEvent) -> void:
	if(event.is_action_pressed("LEFT") or event.is_action_pressed("RIGHT")) and not is_turning:
		is_turning = true
		var turn_dir: int = 0
		if event.is_action_pressed("LEFT"):
			turn_dir = 1
		elif event.is_action_pressed("RIGHT"):
			turn_dir = -1
		for i in range(10):
			rotation_degrees.y += rotation_speed * turn_dir
			await get_tree().create_timer(0.001).timeout
		is_turning = false


## TEST Placeholder code
#func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#if Input.is_action_just_pressed("L_CLICK"):
		#var object: Node3D = $"../House Prototype/Pickable Object"
		#object.global_position.y += 0.25 #This is test for the pickable object.
		#print("Ouch! I am an interactable Pickable object and you just touched me!") #Just some random text to test if it works correctly.
