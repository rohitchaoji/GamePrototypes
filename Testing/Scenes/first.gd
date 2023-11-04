extends Node2D

func _on_emitter_entity_in_scan_range(body):
	$Entity1/Receiver.PDWs = body.PDWs
	$UI/HBoxContainer/CharacteristicValues/PulseWidthValue.text = str($Entity1/Receiver.PDWs[0])
	$UI/HBoxContainer/CharacteristicValues/PRIValue.text = str($Entity1/Receiver.PDWs[1])
	$UI/HBoxContainer/CharacteristicValues/EffectivePowerValue.text = str($Entity1/Receiver.PDWs[2])
	$UI/HBoxContainer/CharacteristicValues/FrequencyValue.text = str($Entity1/Receiver.PDWs[3])
	$UI/RadarVisibility/Indicator.text = " Radar Sees Player"


func _on_emitter_entity_exited_scan_range(_body):
	$UI/HBoxContainer/CharacteristicValues/PulseWidthValue.text = str(0)
	$UI/HBoxContainer/CharacteristicValues/PRIValue.text = str(0)
	$UI/HBoxContainer/CharacteristicValues/EffectivePowerValue.text = str(0)
	$UI/HBoxContainer/CharacteristicValues/FrequencyValue.text = str(0)
	$UI/RadarVisibility/Indicator.text = " Not in Range of Radar(s)"
