extends Node2D

const isSingleClient : bool = false
const isDoubleClient : bool = true

func setHighlight(highlight : int) -> void: 
	$FirstClient.setHighlight(highlight)
	$SecondClient.setHighlight(highlight)


func setColor(color : Color) -> void: 
	$FirstClient.setColor(color)
	$SecondClient.setColor(color)


func interactWith(interactedNode, player) -> void:
	$FirstClient.interactWith(interactedNode, player)
	$SecondClient.interactWith(interactedNode, player)


func getFirstClient() -> Node2D:
	return $FirstClient


func getSecondClient() -> Node2D:
	return $SecondClient


func getIsSingleClient() -> bool:
	return isSingleClient
