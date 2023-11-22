extends Node2D

var foodScene = preload("res://Scenes/Food.tscn") 
@onready var currentImage = $ClientWaitingImage

enum States {IN_QUEUE = 0, WAITING_FOOD = 1, EATING = 2}
enum TimerStates {HAPPY = 0, ANGRY = 1, REALLY_ANGRY = 2}
var choosedFood : Node2D = null
var table : Node2D = null
var isEating = false
var finishedEating = false
var patienceTime : float = 20
var timerTime : float = patienceTime / 3
var clientState : int = 0
var timerState : int = 0

const isSingleClient : bool = true
const isDoubleClient : bool = false

func _ready():
	
	$Timer.start(timerTime) 
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
	stopTimer()
	$ClientWaitingImage.visible = false
	$ClientLookingAtMenuImage.visible = true
	
	currentImage = $ClientLookingAtMenuImage


func askForFood() -> void:
	clientState = 1
	restartState()
	$PatienceTimer.start(patienceTime)
	$ClientLookingAtMenuImage.visible = false
	$ClientAskForFood.visible = true
	
	currentImage = $ClientAskForFood
	if $ClientLookingAtMenuImage.flip_h:
		flipHImage()
	
	get_tree().root.get_child(0).askFoodToCook(choosedFood.plate)


func startEating() -> void:
	clientState = 2
	$PatienceTimer.stop()
	stopTimer()
	
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

func restartState() -> void:
	$Timer.start(timerTime)
	timerState = 0
	deleteEmoji()

func stopTimer() -> void:
	$Timer.stop()
	deleteEmoji()

func deleteEmoji() -> void:
	$EmojiFront/Angry.visible = false
	$EmojiFront/ReallyAngry.visible = false
	
func _on_patience_timer_timeout():
	if clientState == 0:
		if get_parent().name != "DoubleClient":
			get_tree().root.get_child(0).deleteClientFromPatience($".")
		else:
			get_tree().root.get_child(0).deleteClientFromPatience(get_parent())
			get_parent().get_children().clear()
			
	if clientState == 1:
		table.leaveClients(false)


func _on_timer_timeout():
	choosedFood.reduceFoodValue()
	if timerState == 0:
		timerState = 1
		$EmojiFront/Angry.visible = true
	else:
		$EmojiFront/Angry.visible = false
		$EmojiFront/ReallyAngry.visible = true

		
