extends Node2D

@onready var foodPositions : Array[Node2D] =  [
	$SpawnContainer/FirstPlace, 
	$SpawnContainer/SecondPlace, 
	$SpawnContainer/ThirdPlace,
	$SpawnContainer/ForthPlace, 
	$SpawnContainer/FifthPlace
]

var foodScene = preload("res://Scenes/Food.tscn") 
var foodScenesList : Array[Node2D] = [null, null, null, null, null]

const foodHighlightValue : int = 3
const normalHighlightColor : Color = Color.TURQUOISE

func _on_new_food_timer_timeout():
	instatiateFood(foodScene)
#	$NewFoodTimer.stop()

func addToList(newFoodScene : Node2D) -> int:
	for i in range(0, foodScenesList.size(), 1): 
		if foodScenesList[i] == null:
			foodScenesList[i] = newFoodScene
			return i
	return -1


func instatiateFood(sceneType) -> void:
	var newFoodScene = sceneType.instantiate()
	var index : int = addToList(newFoodScene)
	if index != -1:
		foodPositions[index].add_child(newFoodScene)
	newFoodScene.initIceCream()

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


func _on_second_plate_taking_area_2_body_entered(body):
	enterAndExitArea(foodScenesList[1], body, true)


func _on_second_plate_taking_area_2_body_exited(body):
	enterAndExitArea(foodScenesList[1], body, false)
