extends Node2D

func placeFirstClientInLine() -> void:
	$YSort/WatingLine.popClientFromQueue()


func askFoodToCook(foodNumber: int) -> void:
	$CounterSpace.spawnFood(foodNumber)
