extends Area2D


func _on_body_entered(body):
	if (body.can_win):
		body.victory = true
