extends Node2D

const powerup_scene = preload("res://src/Objects/extra_jump.tscn")
@export var next_scene: PackedScene
@onready var extra_jumps_container_node: Node = $ExtraJumps
@onready var jump_trigger_platforms_container_node: Node = $JumpTriggerPlatforms

func restart_level():
	get_tree().reload_current_scene()

func respawn_powerup(pos: Vector2):
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	var new_powerup = powerup_scene.instantiate()
	new_powerup.position = pos
	extra_jumps_container_node.add_child(new_powerup)

func next_level():
	if next_scene != null:
		get_tree().change_scene_to_packed(next_scene)

func trigger_platforms():
	if jump_trigger_platforms_container_node != null:
		var platforms = jump_trigger_platforms_container_node.get_children()
		for platform in platforms:
			platform.movement()
