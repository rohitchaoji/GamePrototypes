extends Area2D

func _ready():
	modulate = Color(0.8, 0.5, 0.5, 1)

func _on_body_entered(body):
	if body.is_in_group("Crates"):
		activate_switch()

func activate_switch():
	var door = get_parent().get_node("Door")
	door.open_door()
	modulate = Color(0.5, 0.7, 1, 1)
