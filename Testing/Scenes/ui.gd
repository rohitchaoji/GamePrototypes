extends CanvasLayer

func _process(_delta):	
	$FuelIndicator/Fuel.text = " Fuel: " + str($"..".fuel)
