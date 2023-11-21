extends Node2D

const isSingleClient : bool = false
const isDoubleClient : bool = true

func setHighlight(highlight : int) -> void: 
	$FirstClient.setHighlight(highlight)
	$SecondClient.setHighlight(highlight)


func setColor(color : Color) -> void: 
	if get_child_count() > 0:
		$FirstClient.setColor(color)
		$SecondClient.setColor(color)

func setClientsTransformToOrigin() -> void:
	$FirstClient.set_position(Vector2.ZERO)
	$SecondClient.set_position(Vector2.ZERO)

func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func getFirstClient() -> Node2D:
	return $FirstClient


func getSecondClient() -> Node2D:
	return $SecondClient


func getIsSingleClient() -> bool:
	return isSingleClient
