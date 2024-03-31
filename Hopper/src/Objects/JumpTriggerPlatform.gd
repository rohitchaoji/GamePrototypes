extends Path2D

@export var speed_scale: float = 1.0
@export var autoreturn: bool = false

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

func _ready():
	animation.speed_scale = speed_scale
	if autoreturn:
		$AnimatableBody2D/Sprite2D.frame = 8
	else:
		$AnimatableBody2D/Sprite2D.frame = 28


func movement():
	if autoreturn:
		autoreturn_movement()
	else:
		no_autoreturn_movement()

func autoreturn_movement():
	if path.progress_ratio == 0:
		animation.play("Forward")
		var timer = get_tree().create_timer(0.3)
		await timer.timeout
		return_to_start()

func no_autoreturn_movement():
	if path.progress_ratio == 0:
		animation.play("Forward")
	elif path.progress_ratio == 1:
		animation.play("Backward")

func return_to_start():
	animation.speed_scale = speed_scale / 6
	animation.play("Backward")
	await animation.animation_finished
	animation.speed_scale = speed_scale
