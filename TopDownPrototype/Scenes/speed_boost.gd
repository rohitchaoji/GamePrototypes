extends Area2D

var rotation_speed: float = 7.5

func _process(delta):
	rotation -= rotation_speed * delta


func _on_body_entered(body):
	body.speed_boosters += 1
	queue_free()
