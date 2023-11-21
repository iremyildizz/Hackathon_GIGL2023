extends Node2D

var foodScene = preload("res://Scenes/Food.tscn") 
@onready var currentImage = $ClientWaitingImage

var choosedFood : Node2D = null
const isSingleClient : bool = true
const isDoubleClient : bool = false

func _ready():
	choosedFood = foodScene.instantiate()
	$ClientAskForFood/FoodSpawnPoint.add_child(choosedFood)
	choosedFood.setRandomizedPlate()


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
	
	get_tree().root.get_child(0).askFoodToCook(choosedFood.plate)


func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func getIsSingleClient() -> bool:
	return isSingleClient
