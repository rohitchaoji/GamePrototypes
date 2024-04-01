extends CanvasLayer


@onready var victory_label: Label = $VictoryLabel
@onready var level_label: Label = $LevelLabel
@onready var dead_label: Label = $DeadLabel
var progress_bar
var level_finish

@export var label_text: String

func _ready():
	victory_label.visible = false
	dead_label.visible = false
	display_level_number()
	level_label.text = label_text
	if get_parent().has_node("level_finish"):
		progress_bar = $ProgressBar
		progress_bar.min_value = 0
		level_finish = get_parent().get_node("level_finish")
		progress_bar.max_value = level_finish.distance_to_bottom

func _physics_process(_delta):
	if progress_bar != null:
		progress_bar.value = level_finish.distance_to_bottom - level_finish.player_distance

func display_level_number():
	level_label.visible = true
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	level_label.visible = false

func display_victory():
	victory_label.visible = true
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	victory_label.visible = false

func display_defeat():
	dead_label.visible = true
	var timer = get_tree().create_timer(1)
	await timer.timeout
	dead_label.visible = false
