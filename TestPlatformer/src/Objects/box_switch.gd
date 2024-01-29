extends StaticBody2D


func _on_switch_detection_body_entered(body):
	get_parent().get_node("Gate").open()
	queue_free()
