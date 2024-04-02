extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var player: CharacterBody2D = get_parent().get_node("Player")
var player_distance: float
var distance_to_bottom: float

func _ready():
	distance_to_bottom = 282.0 - self.position.y


func _physics_process(_delta):
	player_distance = get_player_distance(player)

func get_player_distance(body: CharacterBody2D):
	var distance_vector = self.position - body.position
	return sqrt(distance_vector.x * distance_vector.x + distance_vector.y * distance_vector.y)

func _on_body_entered(body):
	sprite.frame = 390
	body.win_level()
