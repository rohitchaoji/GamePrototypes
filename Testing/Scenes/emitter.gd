extends StaticBody2D

signal entity_in_scan_range(body)
signal entity_exited_scan_range(body)

@export var pulse_width: float
@export var PRI: float
@export var effective_power: float
@export var frequency: float
@export var scan_range: float

var symbol
var PDWs: Array[float]

func _ready():
	PDWs = [pulse_width, PRI, effective_power, frequency]
	$ScanArea.scale = Vector2(scan_range, scan_range)
	$AnimationPlayer.speed_scale = 0.05 * PRI


func _on_scan_area_body_entered(_body):
	entity_in_scan_range.emit(self)


func _on_scan_area_body_exited(_body):
	entity_exited_scan_range.emit(self)
