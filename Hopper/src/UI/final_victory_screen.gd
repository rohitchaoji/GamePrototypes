extends Node2D

@export var credits_scene: PackedScene

func _ready():
	show_credits()

func show_credits():
	var timer = get_tree().create_timer(5.0)
	await timer.timeout
	get_tree().change_scene_to_packed(credits_scene)
