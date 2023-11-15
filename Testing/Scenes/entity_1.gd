extends CharacterBody2D


@export var max_speed: int = 1000
var max_fuel: float = 1000
var fuel: float = max_fuel
var fuel_anim: bool = false
var victory: bool = false
var speed_boosted: bool = false

func _process(_delta):
	var direction = (get_global_mouse_position() - position).normalized()
	look_at(get_global_mouse_position())
	var input_directions = {
		"move_forward": direction,
		"move_backward": -direction,
	}

	for action in ["move_forward", "move_backward"]:
		if Input.is_action_pressed(action) and fuel > 0:
			velocity = input_directions[action] * max_speed
			if !victory:
				fuel -= 1
			move_and_slide()
	
	if (fuel < 200 and fuel_anim == false):
		$FuelIndicatorBlink.play("LowFuel")
		fuel_anim = true
	elif (fuel > 200):
		$FuelIndicatorBlink.stop()
		fuel_anim = false
	
	if (fuel <= 0):
		$UI/GameStatus/Status.text = "Game Over"
	
	if (victory):
		$UI/GameStatus/Status.text = "Victory!"
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "max_speed", 0, 1)
	
	if (speed_boosted and !$SpeedBoostTimer.is_stopped()):
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "max_speed", 3500, 1)
		$SpeedBoostTimer.start()
		


func _on_speed_boost_timer_timeout():
	speed_boosted = false
	var tween = create_tween()
	tween.tween_property(self, "max_speed", 1000, 0.5)
