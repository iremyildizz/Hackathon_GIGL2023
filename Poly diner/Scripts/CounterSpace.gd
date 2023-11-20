extends Node2D

@onready var foodPositions : Array[Node2D] =  [
	$SpawnContainer/FirstPlace, 
	$SpawnContainer/SecondPlace, 
	$SpawnContainer/ThirdPlace,
	$SpawnContainer/ForthPlace, 
	$SpawnContainer/FifthPlace
]

var plateCleanScene = preload("res://Scenes/Food.tscn") 
var foodScenesList : Array[Node2D] = []

const maxFoodScenes = 5

func _on_new_food_timer_timeout():
	print("time out")
	if foodScenesList.size() < maxFoodScenes:
		instatiateFood(plateCleanScene)
	else : 
		$NewFoodTimer.stop()


func instatiateFood(sceneType) -> void:
	var newFoodScene = sceneType.instantiate()
	foodPositions[foodScenesList.size()].add_child(newFoodScene)
	foodScenesList.append(newFoodScene)
