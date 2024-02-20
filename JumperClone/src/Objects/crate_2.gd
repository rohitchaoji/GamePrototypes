extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var standing: bool = false
var blocked: bool = false
var touching_box: bool = false

func _ready():
	$StandArea/CollisionShape2D.disabled = true
	$PlayerBlocker/CollisionShape2D.disabled = true
	$PlayerBlocker/CollisionShape2D2.disabled = true

func _physics_process(delta):
	velocity.y += gravity * delta
	player_or_crate_on_top()
	blocked_()
	box_detection()
	
	if blocked:
		if touching_box:
			$PlayerBlocker/CollisionShape2D.disabled = false
			$PlayerBlocker/CollisionShape2D2.disabled = false
		else:
			$PlayerBlocker/CollisionShape2D.disabled = false
			$PlayerBlocker/CollisionShape2D2.disabled = false
			
		$PlayerBlocker/CollisionShape2D.disabled = false
		$PlayerBlocker/CollisionShape2D2.disabled = false
		if standing:
			$StandArea/CollisionShape2D.disabled = false
			move_and_slide()
		else:
			$StandArea/CollisionShape2D.disabled = true
	elif !blocked:
		if touching_box:
			var tween = get_tree().create_tween()
			if $BoxDetectLeft.is_colliding():
				tween.tween_property(self, "position", position + Vector2(16, 0), 0.1)
			elif $BoxDetectRight.is_colliding():
				tween.tween_property(self, "position", position + Vector2(-16, 0), 0.1)
			
		$PlayerBlocker/CollisionShape2D.disabled = true
		$PlayerBlocker/CollisionShape2D2.disabled = true
		if standing:
			$StandArea/CollisionShape2D.disabled = false
		else:
			$StandArea/CollisionShape2D.disabled = true
		move_and_slide()

func player_or_crate_on_top():
	var c1 = $Standing1.is_colliding()
	var c2 = $Standing2.is_colliding()
	var c3 = $Standing3.is_colliding()
	
	standing = c1 || c2 || c3

func blocked_():
	var c1 = $PushFromLeft.is_colliding()
	var c2 = $PushFromRight.is_colliding()
	blocked = c1 || c2 && is_on_floor()
	

func box_detection():
	var c1 = $BoxDetectLeft.is_colliding()
	var c2 = $BoxDetectRight.is_colliding()
	touching_box = c1 || c2
