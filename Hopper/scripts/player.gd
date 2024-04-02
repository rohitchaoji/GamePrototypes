extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D

@export var SPEED = 160.0
@export var JUMP_VELOCITY = -300.0
@export var coyote_time: float = 150.0
@export var jump_buffer_time: float = 0.2

var direction
var jump_buffered: bool = false
var can_coyote: bool = false
var walljumped_once: bool = false
var extra_jumps: int = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_checkpoint: Vector2
var parent_node: Node2D

var colour_green = Color(0, 1, 0, 1)
var colour_lime = Color(0.8, 1, 0.3, 1)
var colour_white = Color(1, 1, 1, 1)

func _ready():
	player_sprite.play("Move")
	player_sprite.stop()
	parent_node = get_parent()
	last_checkpoint = position


func _physics_process(delta):
	handle_jump(delta)
	handle_movement()
	handle_colour_modulation()
	move_and_slide()


func hazard_hit():
	process_mode = Node.PROCESS_MODE_DISABLED
	player_sprite.play("Dead")
	parent_node.get_node("UILayer").display_defeat()
	
	var timer_2 = get_tree().create_timer(1.0)
	await timer_2.timeout
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	player_sprite.play("Move")
	player_sprite.stop()
	
	get_parent().get_tree().reload_current_scene()
	

func win_level():
	parent_node.get_node("UILayer").display_victory()
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	parent_node.next_level()


func handle_jump(delta):
	if not is_on_floor():
		
		# Gravity only accelerates player downward while in air
		velocity.y += gravity * delta
		
		# Set limit to falling speed
		if velocity.y >= 500:
			velocity.y = 500
		
		# Check if walljump is allowed
		if is_on_wall() and !walljumped_once:
			extra_jumps += 1
			walljumped_once = true
		
		if Input.is_action_just_pressed("jump"):
			# Coyote time implementation
			if can_coyote:
				if velocity.y > 0.0 and velocity.y <= coyote_time:
					extra_jumps = 2
				else:
					extra_jumps = 1
				velocity.y = JUMP_VELOCITY
				can_coyote = false
			
			# Extra jump logic
			if extra_jumps > 0:
				velocity.y = JUMP_VELOCITY
				var tween = get_tree().create_tween()
				tween.tween_property(self, "rotation", direction * 2 * PI, 0.4)
				extra_jumps -= 1
			
			# Causes jump-triggered platforms to move
			parent_node.trigger_platforms()

			# Creates a jump buffer that lasts for a given time
			jump_buffered = true
			var timer = get_tree().create_timer(jump_buffer_time)
			await timer.timeout
			jump_buffered = false
	
	if is_on_floor():
		# Set the ability to coyote and walljump to true. Remove extra jumps.
		can_coyote = true
		walljumped_once = false
		extra_jumps = 0
		
		# Perform a jump on jump input while on ground, or if jump was buffered while in air.
		if Input.is_action_just_pressed("jump") or jump_buffered:
			velocity.y = JUMP_VELOCITY
			can_coyote = false
			extra_jumps = 1
			parent_node.trigger_platforms()


func handle_movement():
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		player_sprite.play("Move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_sprite.stop()
		
	if direction > 0:
		player_sprite.flip_h = false
	elif direction < 0:
		player_sprite.flip_h = true


func handle_colour_modulation():
	if is_on_floor():
		modulate = colour_green
	
	if extra_jumps >= 2:
		modulate = colour_green
	
	if extra_jumps == 1:
		modulate = colour_lime
	
	if extra_jumps == 0 and not is_on_floor():
		modulate = colour_white
