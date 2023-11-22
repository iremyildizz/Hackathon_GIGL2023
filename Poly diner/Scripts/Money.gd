extends Node2D

enum MoneyType {MONEY = 0, COIN = 1}

const possiblesVlues : int = 2
var money : int = 0
var image : Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setRandomizedMoney()

func setRandomizedMoney() -> void:
	var randomValue = randi() % possiblesVlues
	setMoney(randomValue)


func setMoney(moneyValue : int) -> void:
	if moneyValue == MoneyType.MONEY:
		image = $Money
	if moneyValue == MoneyType.COIN:
		image = $Coin
	
	image.visible = true	
	money = moneyValue

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func moneyInit() -> void:
	$Money.visible = true

func coinInit() -> void:
	$Coin.visible = true
