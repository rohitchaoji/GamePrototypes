extends StaticBody2D

var player_falling_on_spikes: bool = false

func _ready():
	$CollisionArea/CollisionShape2D.disabled = true

func _physics_process(_delta):
	player_falling()
	if player_falling_on_spikes:
		$CollisionArea/CollisionShape2D.disabled = false
	else:
		$CollisionArea/CollisionShape2D.disabled = true


func player_falling():
	var c1 = $PlayerFall1.is_colliding()
	var c2 = $PlayerFall2.is_colliding()
	var c3 = $PlayerFall3.is_colliding()
	var c4 = $PlayerFall4.is_colliding()
	var c5 = $PlayerFall5.is_colliding()

	#var c8 = $PlayerFall8.is_colliding()
	#var c9 = $PlayerFall9.is_colliding()
	#|| c8 || c9
	
	if c1 || c2 || c3 || c4 || c5:
		player_falling_on_spikes = true
	else:
		player_falling_on_spikes = false


func _on_collision_area_body_entered(body):
	if body.is_in_group("Player"):
		body.hazard_hit()
