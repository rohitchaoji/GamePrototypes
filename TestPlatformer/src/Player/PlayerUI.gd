extends CanvasLayer

@onready var health_bar = $HealthIndicator

func update_health(max_health, health):
	health_bar.max_value = max_health
	health_bar.value = health
	
func display_game_over():
	$GameOverIndicator.text = "Game Over"
