extends Node2D

@export var menu_scene: PackedScene

func back_to_menu():
	get_tree().change_scene_to_packed(menu_scene)

func _on_back_button_pressed():
	back_to_menu()
