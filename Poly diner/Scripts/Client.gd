extends Node2D

@onready var currentImage = $ClientWaitingImage

const isSingleClient : bool = true
const isDoubleClient : bool = false

func setHighlight(highlight : int) -> void: 
	currentImage.material.set_shader_parameter("line_thickness", highlight)


func setColor(color: Color) -> void: 
	currentImage.material.set_shader_parameter("line_color", color)


func flipHImage() -> void :
	currentImage.flip_h = true
	

func lookAtMenu() -> void:
	$ClientWaitingImage.visible = false
	$ClientLookingAtMenuImage.visible = true
	
	currentImage = $ClientLookingAtMenuImage


func askForFood() -> void:
	$ClientLookingAtMenuImage.visible = false
	$ClientAskForFood.visible = true
	
	currentImage = $ClientAskForFood
	if $ClientLookingAtMenuImage.flip_h:
		flipHImage()


func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func getIsSingleClient() -> bool:
	return isSingleClient
