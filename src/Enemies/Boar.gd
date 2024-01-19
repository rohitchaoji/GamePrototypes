extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 75
@onready var player = get_node("../Player")
var chase = false
var attack_chase = false
var can_damage = true
var direction

func _ready():
	$AnimatedSprite2D.play("Idle")


func _physics_process(delta):
	velocity.y += gravity * delta
		
	if chase:
		if $AnimatedSprite2D.animation != "Hit":
			if attack_chase:
				$AnimatedSprite2D.play("Run")
			else:
				$AnimatedSprite2D.play("Walk")
		player = get_node("../Player")
		direction = (player.position - self.position).normalized()
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction.x * speed
	else:
		if $AnimatedSprite2D.animation != "Hit":
			$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	move_and_slide()

func hit():
	$AnimatedSprite2D.play("Hit")
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_detection_area_body_entered(body):
	if body.name == "Player":
		chase = true
	elif body.dead:
		chase = false
		$AnimatedSprite2D.play("Idle")


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		chase = false
	elif body.dead:
		chase = false
		$AnimatedSprite2D.play("Idle")


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		speed = 150
		attack_chase = true
	elif body.dead:
		attack_chase = false
		$AnimatedSprite2D.play("Idle")


func _on_attack_area_body_exited(body):
	if body.name == "Player":
		speed = 75
		attack_chase = false
	elif body.dead:
		attack_chase = false
		$AnimatedSprite2D.play("Idle")


func _on_damage_area_body_entered(body):
	if body.name == "Player" and !body.dead:
		if can_damage:
			can_damage = false
			body.damage_from_boar()
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position + (-sign(direction.x) * Vector2(40, 0)), 0.75)
			await get_tree().create_timer(0.75).timeout
			can_damage = true
		
