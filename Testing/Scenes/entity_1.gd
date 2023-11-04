extends CharacterBody2D


@export var max_speed: int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = (get_global_mouse_position() - position).normalized()
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_forward"):
		velocity = direction * max_speed
		move_and_slide()
	if Input.is_action_pressed("move_backward"):
		velocity = -direction * max_speed
		move_and_slide()
	if Input.is_action_pressed("move_left"):
		velocity = direction.rotated(PI/2) * (3 * max_speed / 4)
		move_and_slide()
	if Input.is_action_pressed("move_right"):
		velocity = -direction.rotated(PI/2) * (3 * max_speed / 4)
		move_and_slide()
