extends CharacterBody2D

func _ready():
	$Sprite2D.frame = 56
	modulate = Color(1, 0.2, 0.2, 1)

func open_door():
	$Sprite2D.frame = 57
	process_mode = Node.PROCESS_MODE_DISABLED
	modulate = Color(0.2, 0.5, 1, 1)
