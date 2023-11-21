extends Node2D

func placeFirstClientInLine() -> void:
	$YSort/WatingLine.popClientFromQueue()


func askFoodToCook(foodNumber: int) -> void:
	$CounterSpace.addFoodToQueue(foodNumber)


func takeCounterFood(food: Node2D) -> void:
	$CounterSpace.deleteFoodFromList(food)
