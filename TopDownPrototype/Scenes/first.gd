extends Node2D

func _process(_delta):
	$Entity1/UI/CheckpointCounter/Checkpoints.text = " Checkpoints: " + str($Entity1.checkpoints_reached) + " / " + str($Ground/Checkpoints.get_child_count())
	if $Entity1.checkpoints_reached == $Ground/Checkpoints.get_child_count():
		$Entity1.can_win = true
		$Ground/Goals/Goal/AnimationPlayer.play("Accessible")
