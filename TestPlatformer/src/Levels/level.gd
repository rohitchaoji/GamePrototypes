extends Node2D


func _on_player_level_reset():
	get_tree().reload_current_scene()
