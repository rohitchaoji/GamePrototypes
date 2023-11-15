extends Camera2D

@onready var default_zoom = Vector2(0.5, 0.5)


func _ready():
	self.zoom = default_zoom


func _process(_delta):
	if Input.is_action_just_pressed("zoom_out") and self.zoom > Vector2(0.33, 0.33):
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "zoom", self.zoom - Vector2(0.1, 0.1), 0.25)
		
	if Input.is_action_just_pressed("zoom_in") and self.zoom < Vector2(1, 1):
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "zoom", self.zoom + Vector2(0.1, 0.1), 0.25)
	
	if Input.is_action_pressed("zoom_reset"):
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "zoom", default_zoom, 0.25)
