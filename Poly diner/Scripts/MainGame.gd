extends Node2D

func placeFirstClientInLine() -> void:
	$YSort/WatingLine.popClientFromQueue()


func askFoodToCook(foodNumber: int) -> void:
	$CounterSpace.addFoodToQueue(foodNumber)


func takeCounterFood(food: Node2D) -> void:
	$CounterSpace.deleteFoodFromList(food)


func getPayment(value: int) -> void:
	$CashRegister.addProfit(value)


func deleteClientFromPatience(client : Node2D) -> void:
	$YSort/WatingLine.popClientFromQueue()
	if $YSort/Player.interactedNode == client:
		$YSort/Player.interactedNode = null
