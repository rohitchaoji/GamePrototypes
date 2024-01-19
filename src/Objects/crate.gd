extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
	velocity.y += gravity * delta
	move_and_slide()


func _on_push_area_body_entered(body):
	if body.is_in_group("Player"):
		body.SPEED = 100.0


func _on_push_area_body_exited(body):
	if body.is_in_group("Player"):
		body.SPEED = 250.0
