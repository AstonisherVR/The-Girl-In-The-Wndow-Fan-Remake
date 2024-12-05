extends Node3D

var is_turning := false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	handle_input()

func handle_input() -> void:
	if Input.is_action_just_pressed("LEFT") and not is_turning:
		rotate_player(9)
	elif Input.is_action_just_pressed("RIGHT") and not is_turning:
		rotate_player(-9)

func rotate_player(rotation_speed: float) -> void:
	is_turning = true
	for i in range(10):
		rotation_degrees.y += rotation_speed
		await get_tree().create_timer(0.001).timeout
	is_turning = false

# TEST Placeholder code
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if Input.is_action_just_pressed("L_CLICK"):
		var object: Node3D = $"../House Prototype/Pickable Object"
		object.global_position.y += 0.25 #This is test for the pickable object.
		print("Ouch! I am an interactable Pickable object and you just touched me!") #Just some random text to test if it works correctly.
