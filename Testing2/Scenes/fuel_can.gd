extends Area2D

var rotation_speed: int = 5
@export var fuel_amount: int = 500

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.fuel += fuel_amount
	queue_free()
