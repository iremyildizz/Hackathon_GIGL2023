extends Node2D

func setHighlight(highlight : int) -> void: 
	$FirstClient.setHighlight(highlight)
	$SecondClient.setHighlight(highlight)
