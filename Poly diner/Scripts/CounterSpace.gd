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
<<<<<<< HEAD
	var index : int = addToList(newFoodScene)
	if index != -1:
		foodPositions[index].add_child(newFoodScene)
	newFoodScene.initPoutine()
	
=======
	foodPositions[foodScenesList.size()].add_child(newFoodScene)
	foodScenesList.append(newFoodScene)


func _on_frist_plate_taking_area_body_entered(body):
	pass
>>>>>>> 1cf02311318182beb5d0629fbc5f065259749da1
