extends Node2D


func _on_area_2d_body_exited(body):
	body.position = $"..".position
