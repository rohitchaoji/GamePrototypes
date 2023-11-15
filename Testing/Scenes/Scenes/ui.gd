extends CanvasLayer

func _process(_delta):	
	$Indicator/Fuel.text = " Fuel: " + str($"..".fuel)
	$Indicator/Boosters.text = " Boosters: " + str($"..".speed_boosters)
