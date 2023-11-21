extends Node2D

const isSingleClient : bool = true
const isDoubleClient : bool = false

func setHighlight(highlight : int) -> void: 
	$ClientImage.material.set_shader_parameter("line_thickness", highlight)


func setColor(color: Color) -> void: 
	$ClientImage.material.set_shader_parameter("line_color", color)


func flipHImage() -> void :
	$ClientImage.flip_h = true
	

func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func getIsSingleClient() -> bool:
	return isSingleClient
