extends CharacterBody2D


@export var SPEED = 160.0
@export var JUMP_VELOCITY = -300.0
@export var coyote_time: float = 150.0
@export var jump_buffer_time: float = 0.2

var direction
var jump_buffered: bool = false
var can_wall_jump: bool = true
var can_double_jump: bool = false
var can_coyote: bool = false
var can_double_coyote_jump: bool = false
var just_left_floor: bool = false
var has_jumped_once: bool = false
var walljumped_once: bool = false
var dashing: bool = false
var extra_jumps: int = 1
var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = default_gravity

func _ready():
	$AnimatedSprite2D.play("Move")
	$AnimatedSprite2D.stop()

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y >= 500:
			velocity.y = 500
		
		if is_on_wall() and !walljumped_once:
			extra_jumps += 1
			walljumped_once = true
		
		
		if Input.is_action_just_pressed("jump"):
			if velocity.y > 0.0 and velocity.y <= coyote_time and can_coyote:
				velocity.y = JUMP_VELOCITY
				extra_jumps = 2
				can_coyote = false
				
			if extra_jumps > 0:
				velocity.y = JUMP_VELOCITY
				var tween = get_tree().create_tween()
				tween.tween_property(self, "rotation", direction * 2 * PI, 0.4)
				extra_jumps -= 1
			
			get_parent().trigger_platforms()

			
			jump_buffered = true
			var timer = get_tree().create_timer(jump_buffer_time)
			await timer.timeout
			jump_buffered = false
	
	if is_on_floor():
		can_coyote = true
		walljumped_once = false

		if Input.is_action_just_pressed("jump") or jump_buffered:
			velocity.y = JUMP_VELOCITY
			can_coyote = false
			extra_jumps = 1
			get_parent().trigger_platforms()
		
	
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()
		
		
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
		$SlowdownArea/CollisionShape2D.position.x = 6
	elif direction < 0:
		$SlowdownArea/CollisionShape2D.position.x = -6
		$AnimatedSprite2D.flip_h = true
	
	if extra_jumps >= 2 and not is_on_floor():
		modulate = Color(1, 1, 0, 1)
	
	elif extra_jumps < 2 or is_on_floor():
		modulate = Color(0.75, 0.85, 1, 1)

	move_and_slide()


func hazard_hit():
	$AnimatedSprite2D.play("Dead")
	process_mode = Node.PROCESS_MODE_DISABLED
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	get_parent().restart_level()


func _on_slowdown_area_body_entered(body):
	if body.is_in_group("Crates"):
		SPEED = 80.0


func _on_slowdown_area_body_exited(body):
	if body.is_in_group("Crates"):
		SPEED = 160.0

func win_level():
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	get_parent().next_level()
