extends Node2D

const powerup_scene = preload("res://src/Objects/extra_jump.tscn")
const player_scene = preload("res://src/Player/player.tscn")
@export var next_scene: PackedScene

func restart_level():
	get_tree().reload_current_scene()


func respawn_player(pos: Vector2):
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	var res_player = player_scene.instantiate()
	res_player.position = pos
	add_child(res_player)


func respawn_powerup(pos: Vector2):
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	var new_powerup = powerup_scene.instantiate()
	new_powerup.position = pos
	add_child(new_powerup)

func next_level():
	if next_scene != null:
		get_tree().change_scene_to_packed(next_scene)

func trigger_platforms():
	if $JumpTriggerPlatforms != null:
		var platforms = $JumpTriggerPlatforms.get_children()
		for platform in platforms:
			platform.movement()
