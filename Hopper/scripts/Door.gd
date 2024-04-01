extends CharacterBody2D

func _ready():
	$Sprite2D.frame = 56

func open_door():
	$Sprite2D.frame = 58
	process_mode = Node.PROCESS_MODE_DISABLED
