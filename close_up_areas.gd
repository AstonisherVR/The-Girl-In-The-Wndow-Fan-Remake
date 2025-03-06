extends Node
@onready var close_up_areas: Array[Node] = get_children()
@onready var go_back_button: GoBackButton = %"Go Back Button"

func _ready() -> void:
	for close_up_area: CloseUpArea in close_up_areas:
		go_back_button.pressed.connect(close_up_area.reset)
