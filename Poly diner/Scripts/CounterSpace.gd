extends Node2D

@onready var foodPositions : Array[Node2D] = [
	$SpawnContainer/FirstPlace, 
	$SpawnContainer/SecondPlace, 
	$SpawnContainer/ThirdPlace,
	$SpawnContainer/FourthPlace, 
	$SpawnContainer/FifthPlace
]

var foodScene = preload("res://Scenes/Food.tscn") 
var foodScenesList : Array[Node2D] = [null, null, null, null, null]
var foodQueue : Array[int] = []

const foodHighlightValue : int = 3
const normalHighlightColor : Color = Color.TURQUOISE


func addFoodToQueue(foodNumber: int):
	foodQueue.append(foodNumber)


func _on_new_food_timer_timeout():
	if !isPlaceLeft():
		return
		
	var nextFood = foodQueue.pop_front()
	
	if nextFood != null:
		instatiateFood(foodScene, nextFood)


func instatiateFood(sceneType, foodType: int) -> void:
	var newFoodScene = sceneType.instantiate()
	newFoodScene.setPlate(foodType)
	var index : int = addToList(newFoodScene)
	if index != -1:
		foodPositions[index].add_child(newFoodScene)


func addToList(newFoodScene : Node2D) -> int:
	for i in range(0, foodScenesList.size(), 1): 
		if foodScenesList[i] == null:
			foodScenesList[i] = newFoodScene
			return i
			
	return -1


func deleteFoodFromList(food : Node2D) -> void:
	for i in range(0, foodScenesList.size(), 1): 
		if foodScenesList[i] == food:
			foodScenesList[i] = null

func isPlaceLeft() -> bool:
	for i in range(0, foodScenesList.size(), 1): 
		if foodScenesList[i] == null:
			return true
	return false


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func enterAndExitArea(foodSelected : Node2D, body, isEntered : bool ):
	if isBodyPlayer(body) and foodSelected != null:
		foodSelected.setColor(normalHighlightColor)
		
		if isEntered:
			foodSelected.setHighlight(foodHighlightValue)
			body.setCurrentSelection(foodSelected)
		else:
			foodSelected.setHighlight(0)
			body.setCurrentSelection(null)


func _on_first_plate_taking_area_body_entered(body):
	enterAndExitArea(foodScenesList[0], body, true)


func _on_first_plate_taking_area_body_exited(body):
	enterAndExitArea(foodScenesList[0], body, false)


func _on_second_plate_taking_area_body_entered(body):
	enterAndExitArea(foodScenesList[1], body, true)


func _on_second_plate_taking_area_body_exited(body):
	enterAndExitArea(foodScenesList[1], body, false)


func _on_third_plate_taking_area_body_entered(body):
	enterAndExitArea(foodScenesList[2], body, true)


func _on_third_plate_taking_area_body_exited(body):
	enterAndExitArea(foodScenesList[2], body, false)
	

func _on_fourth_plate_taking_area_body_entered(body):
	enterAndExitArea(foodScenesList[3], body, true)


func _on_fourth_plate_taking_area_body_exited(body):
	enterAndExitArea(foodScenesList[3], body, false)


func _on_fifth_plate_taking_area_body_entered(body):
	enterAndExitArea(foodScenesList[4], body, true)


func _on_fifth_plate_taking_area_body_exited(body):
	enterAndExitArea(foodScenesList[4], body, false)
