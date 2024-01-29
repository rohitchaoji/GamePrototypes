extends CharacterBody2D


@onready var push_raycast_left = $PushRayCastLeft
@onready var push_raycast_right = $PushRayCastRight
@onready var stand_raycast_1 = $StandRayCast1
@onready var stand_raycast_2 = $StandRayCast2
@onready var stand_raycast_3 = $StandRayCast3
@onready var stand_raycast_4 = $StandRayCast4
@onready var stand_raycast_5 = $StandRayCast5


var blocked: bool = false
var standing: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$BlockedBox/CollisionShape2D.disabled = true
	$StandArea/CollisionShape2D.disabled = true


func _physics_process(delta):
	velocity.y += gravity * delta
	pushing_raycast_collisions()
	standing_raycast_collisions()
	if blocked:
		$BlockedBox/CollisionShape2D.disabled = false
		if standing:
			move_and_slide()
			$StandArea/CollisionShape2D.disabled = false
		else:
			$StandArea/CollisionShape2D.disabled = true
	elif !blocked:
		if standing:
			$StandArea/CollisionShape2D.disabled = false
		else:
			$StandArea/CollisionShape2D.disabled = true
		move_and_slide()


func pushing_raycast_collisions():
	blocked = push_raycast_left.is_colliding() || push_raycast_right.is_colliding()
	return blocked


func standing_raycast_collisions():
	var c1 = stand_raycast_1.is_colliding()
	var c2 = stand_raycast_2.is_colliding()
	var c3 = stand_raycast_3.is_colliding()
	var c4 = stand_raycast_4.is_colliding()
	var c5 = stand_raycast_5.is_colliding()
	
	standing = c1 || c2 || c3 || c4 || c5
	return standing


func _on_push_area_body_entered(body):
	if body.is_in_group("Player"):
		body.SPEED = 100.0


func _on_push_area_body_exited(body):
	if body.is_in_group("Player"):
		body.SPEED = 250.0


func _on_blocked_box_body_entered(body):
	if body.is_in_group("Player") || body.is_in_group("Enemies"):
		body.box_block()


func _on_blocked_box_body_exited(body):
	if body.is_in_group("Player") || body.is_in_group("Enemies"):
		body.box_unblock()
