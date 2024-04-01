extends Camera2D


@onready var levelSpace: ColorRect  = get_parent().get_node("ColorRect")
@onready var player: CharacterBody2D = get_parent().get_node("Player")
var original_pos_y: float


func _ready():
	original_pos_y = position.y


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
