extends Area2D

func _ready():
	$AnimationPlayer.play("ExpandContract")



func _on_body_entered(body):
	get_parent().get_node("Door").open()
	queue_free()
