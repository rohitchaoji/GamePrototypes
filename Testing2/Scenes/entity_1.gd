extends CharacterBody2D


@export var max_speed: int = 1000
var speed: int = max_speed
var speed_boosters: int = 0
var checkpoints_reached: int = 0
var max_fuel: float = 1000
var fuel: float = max_fuel
var fuel_anim: bool = false
var victory: bool = false
var can_boost: bool = true
var can_win: bool = false
var direction


func _process(_delta):
	direction = (get_global_mouse_position() - position).normalized()
	look_at(get_global_mouse_position())
	var input_directions = {
		"move_forward": direction,
		"move_backward": -direction,
	}


	for action in ["move_forward", "move_backward"]:
		if Input.is_action_pressed(action) and fuel > 0:
			velocity = input_directions[action] * speed
			if !victory:
				fuel -= 1
			move_and_slide()
	
	if Input.is_action_just_pressed("boost") and speed_boosters > 0 and can_boost:
		$BoostExhaust.emitting = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "speed", speed + 1000, 0.05)
		speed_boosters -= 1
		can_boost = false
	
	if (fuel < 200 and fuel_anim == false):
		$FuelIndicatorBlink.play("LowFuel")
		fuel_anim = true
	elif (fuel > 200):
		$FuelIndicatorBlink.stop()
		fuel_anim = false
	
	if (speed > max_speed):
		await get_tree().create_timer(1.5).timeout
		var tween = get_tree().create_tween()
		tween.tween_property(self, "speed", max_speed, 0.05)
		$BoostExhaust.emitting = false
		$SpeedBoostTimer.start()
	
	if (fuel <= 0):
		$UI/GameStatus/Status.text = "Game Over"
	
	if (victory):
		$UI/GameStatus/Status.text = "Victory!"
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "speed", 0, 1)


func _on_speed_boost_timer_timeout():
	can_boost = true
