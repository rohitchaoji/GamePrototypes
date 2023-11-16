extends Area2D

var reached_by_player: bool = false

func _ready():
	$AnimationPlayer.seek(0, true)


func _on_body_entered(body):
	if !reached_by_player:
		body.checkpoints_reached += 1
		reached_by_player = true
	
	if reached_by_player:
		$AnimationPlayer.play("Reached")
