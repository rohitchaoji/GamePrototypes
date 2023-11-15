extends Node

@onready var PDWs: Array[float] = [0, 0, 0, 0]

func _process(_delta):
	if (!$"..".in_radar_range):
		PDWs = [0, 0, 0, 0]

