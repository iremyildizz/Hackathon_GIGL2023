extends Node2D

func setHighlight(highlight : int) -> void: 
	$FirstClient.setHighlight(highlight)
	$SecondClient.setHighlight(highlight)


func setColor(color : Color) -> void: 
	$FirstClient.setColor(color)
	$SecondClient.setColor(color)
