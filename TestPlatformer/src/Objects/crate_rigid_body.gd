extends RigidBody2D



func _ready():
	pass


func _physics_process(delta):
	$SlowdownArea/CollisionShape2D.global_rotation_degrees = 0


func _on_slowdown_area_body_entered(body):
	if body.is_in_group("Player"):
		body.SPEED = 100.0


func _on_slowdown_area_body_exited(body):
	if body.is_in_group("Player"):
		body.SPEED = 250.0
