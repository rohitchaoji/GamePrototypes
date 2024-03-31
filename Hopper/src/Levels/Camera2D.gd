extends Camera2D

var player
var levelSpace
var original_pos_y: float
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	levelSpace = get_parent().get_node("ColorRect")
	original_pos_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_distace = position.y - player.position.y
	if player_distace > 120:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, position.y - 144), 0.2)
	elif player_distace < -120:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, position.y + 144), 0.2)
		
	if position.y > original_pos_y:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, original_pos_y), 0.2)
	
	elif position.y < levelSpace.position.y + 144:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x, levelSpace.position.y + 144), 0.2)
