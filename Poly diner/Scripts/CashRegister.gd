extends Node2D

var startingMoney : int = 0
var debtMoney : int = 130

func _ready():
	$Image/Debt.text = str(debtMoney)
	$Image/Profit.text = str(startingMoney)


func addProfit(value: int) -> void:
	startingMoney += value
	$Image/Profit.text = str(startingMoney)

