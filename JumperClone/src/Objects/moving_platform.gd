extends Path2D

@export var speed_scale: float = 1.0
@export var looping: bool = true

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

func _ready():
	animation.speed_scale = speed_scale
	if looping:
		animation.play("Loop")
	else:
		animation.play("BackForth")
