extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var door = get_parent().get_node("Door")
		if door != null:
			door.open_door()
			queue_free()
