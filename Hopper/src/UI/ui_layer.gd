extends CanvasLayer

var progress_bar
var level_finish

@export var label_text: String

func _ready():
	$VictoryLabel.visible = false
	$DeadLabel.visible = false
	display_level_number()
	$LevelLabel.text = label_text
	if get_parent().has_node("level_finish"):
		progress_bar = $ProgressBar
		progress_bar.min_value = 0
		level_finish = get_parent().get_node("level_finish")
		progress_bar.max_value = level_finish.distance_to_bottom

func _physics_process(_delta):
	if progress_bar != null:
		progress_bar.value = level_finish.distance_to_bottom - level_finish.player_distance

func display_level_number():
	$LevelLabel.visible = true
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	$LevelLabel.visible = false

func display_victory():
	$VictoryLabel.visible = true
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	$VictoryLabel.visible = false

func display_defeat():
	$DeadLabel.visible = true
	var timer = get_tree().create_timer(1)
	await timer.timeout
	$DeadLabel.visible = false
