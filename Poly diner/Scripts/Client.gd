extends Node2D

var foodScene = preload("res://Scenes/Food.tscn") 
@onready var currentImage = $ClientWaitingImage

var choosedFood : Node2D = null
var table : Node2D = null
var isEating = false
var finishedEating = false
var patienceTime : int = 10

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


func setTable(newTable: Node2D):
	table = newTable


func flipHImage() -> void :
	currentImage.flip_h = true
	

func lookAtMenu() -> void:
	$ClientWaitingImage.visible = false
	$ClientLookingAtMenuImage.visible = true
	
	currentImage = $ClientLookingAtMenuImage


func askForFood() -> void:
	$PatienceTimer.start(patienceTime)
	$ClientLookingAtMenuImage.visible = false
	$ClientAskForFood.visible = true
	
	currentImage = $ClientAskForFood
	if $ClientLookingAtMenuImage.flip_h:
		flipHImage()
	
	get_tree().root.get_child(0).askFoodToCook(choosedFood.plate)


func startEating() -> void:
	isEating = true
	$EatingTimer.start()
	
	$ClientAskForFood.visible = false
	$ClientEatingImage.visible = true
	
	currentImage = $ClientEatingImage
	choosedFood.get_parent().remove_child(choosedFood)
	
	if $ClientLookingAtMenuImage.flip_h:
		$BackEatingPoint.add_child(choosedFood)
		flipHImage()
	else:
		$FrontEatingPoint.add_child(choosedFood)


func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func getIsSingleClient() -> bool:
	return isSingleClient


func getIsEating() -> bool:
	return isEating


func getFinishedEating() -> bool:
	return finishedEating


func _on_eating_timer_timeout():
	finishedEating = true
	choosedFood.clearPlate()
	choosedFood.makePlateDirty()
	table.clientFinishedEating()

func makeClientInvisible():
	currentImage.visible = false


func _on_patience_timer_timeout():
	currentImage.visible = false
