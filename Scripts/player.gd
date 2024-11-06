extends Node3D

@export var degrees_to_rotate := 90

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_input(delta)

func handle_input(delta):
	if Input.is_action_just_pressed("LEFT"):
		#rotation_degrees.y += degrees_to_rotate
		for i in range(45):
			rotation_degrees.y += 2
			await get_tree().create_timer(delta).timeout

	if Input.is_action_just_pressed("RIGHT"):
		#rotation_degrees.y -= degrees_to_rotate
		for i in range(45):
			rotation_degrees.y -= 2
			await get_tree().create_timer(delta).timeout

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if Input.is_action_just_pressed("L_CLICK"):
		$"../House Prototype/Pickable Object".position.y += 0.25 #This is test for the pickable object.
		print("Ouch! I am an interactable Pickable object and you just touched me!") #Just some random text to test if it works correctly.
