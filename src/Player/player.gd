extends CharacterBody2D

const JUMP_VELOCITY = -350.0
const MaxHealth: int = 10

var SPEED = 250.0
var Health: int = 10
var direction
var jumping: bool = false
var attacking: bool = false
var dead: bool = false
var can_restart: bool = false
var invulnerable: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal level_reset

func _ready():
	$WeaponHitbox/Hitbox.disabled = true
	$PlayerUI.update_health(MaxHealth, Health)

func _physics_process(delta):
	if Health > 0:
		if not is_on_floor():
			velocity.y += gravity * delta
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if velocity.y == 0:
			jumping = false
		else:
			if velocity.y > 0:
				if !attacking:
					$AnimatedSprite2D.play("JumpDescend")
				jumping = true
			elif velocity.y < 0:
				if !attacking:
					$AnimatedSprite2D.play("JumpAscend")
				jumping = true
		
		direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			if !attacking:
				$AnimatedSprite2D.play("Move")
				if direction < 0:
					$AnimatedSprite2D.offset.y = -1
					$AnimatedSprite2D.flip_h = true
					$WeaponHitbox/Hitbox.position.x = -25
					
				elif direction > 0:
					$AnimatedSprite2D.offset.y = -1
					$AnimatedSprite2D.flip_h = false
					$WeaponHitbox/Hitbox.position.x = 15
		else:
			if !jumping:
				if !attacking:
					$AnimatedSprite2D.play("Idle")
					$AnimatedSprite2D.offset.y = 4
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
		if Input.is_action_just_pressed("attack"):
			attacking = true
			invulnerable = true
			$AnimatedSprite2D.offset.y = 0.75
			$AnimatedSprite2D.play("Attack")
			await get_tree().create_timer(0.2).timeout
			$WeaponHitbox/Hitbox.disabled = false
			await get_tree().create_timer(0.1).timeout
			$WeaponHitbox/Hitbox.disabled = true
			attacking = false
			invulnerable = false
	
	elif Health <= 0:
		if !dead:
			$AnimatedSprite2D.play("Death")
			$AnimatedSprite2D.offset.y = -5
			await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("Dead")
		dead = true
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(1).timeout
		$PlayerUI.display_game_over()
		can_restart = true
	
	if can_restart:
		if Input.is_action_just_pressed("restart_level"):
			restart_level()

func restart_level():
	level_reset.emit()

func _on_weapon_hitbox_body_entered(body):
	if body.is_in_group("Enemies"):
		body.hit()

func damage_from_boar():
	if (!dead and !invulnerable):
		self.Health = self.Health - 1
		$PlayerUI.update_health(MaxHealth, Health)
