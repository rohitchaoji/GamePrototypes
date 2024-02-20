extends Area2D

var sprite: Sprite2D

func _ready():
	sprite = $Sprite2D



func _on_body_entered(body):
	sprite.frame = 390
	body.win_level()
