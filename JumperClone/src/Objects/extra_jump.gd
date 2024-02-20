extends Area2D



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.extra_jumps += 1
		get_parent().respawn_powerup(position)
	queue_free()
