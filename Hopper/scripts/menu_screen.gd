extends Node2D

@export var start_scene: PackedScene
@onready var credits = "res://src/UI/credits_screen.tscn"

func new_game():
	get_tree().change_scene_to_packed(start_scene)

func exit_game():
	get_tree().quit()

func display_credits():
	get_tree().change_scene_to_file(credits)


func _on_new_game_pressed():
	new_game()


func _on_exit_game_pressed():
	exit_game()

func _on_credits_pressed():
	display_credits()
