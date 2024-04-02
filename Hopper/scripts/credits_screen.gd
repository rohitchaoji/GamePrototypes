extends Node2D

@onready var menu_scene = "res://src/UI/menu_screen.tscn"

func back_to_menu():
	get_tree().change_scene_to_file(menu_scene)

func _on_back_button_pressed():
	back_to_menu()
