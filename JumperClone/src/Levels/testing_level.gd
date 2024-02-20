extends Node2D

const powerup_scene = preload("res://src/Objects/extra_jump.tscn")
var next_scene: PackedScene

func _ready():
	pass
	next_scene = preload("res://src/Levels/level_2.tscn")

func restart_level():
	get_tree().reload_current_scene()

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
