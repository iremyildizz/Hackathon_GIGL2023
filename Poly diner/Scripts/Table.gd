extends StaticBody2D

var moneyScene = preload("res://Scenes/Money.tscn")
@onready var clientPositions : Array[Node2D] = [$ClientPlacesPoints/FirstPlace, $ClientPlacesPoints/SecondPlace]

var clienScenestList : Array[Node2D] = []
var clientsAreWaitingForFood = false
var finishedTable = false

const tableHighlightValue : int = 3
const noHighlightColor : Color = Color(Color.BLACK, 0)
const normalHighlightColor : Color = Color.TURQUOISE
const paymentValue = 15

func _on_selection_area_body_entered(body):
	if isBodyPlayer(body):
		setColor(normalHighlightColor)
		setHighlight(tableHighlightValue)
		body.setCurrentSelection($".")


func _on_selection_area_body_exited(body):
	if isBodyPlayer(body):
		setColor(normalHighlightColor)
		setHighlight(0)
		body.setCurrentSelection(null)


func interactWith(interactedNode, player) -> void:
	if interactedNode.has_method("getIsSingleClient") and clienScenestList.is_empty():
		get_tree().root.get_child(0).placeFirstClientInLine()
		
		if interactedNode.getIsSingleClient():
			instatiateClient(interactedNode)
		else:
			interactedNode.setClientsTransformToOrigin()
			interactedNode.setColor(noHighlightColor)
			
			var firstClient : Node2D = interactedNode.getFirstClient()
			firstClient.get_parent().remove_child(firstClient)
			instatiateClient(firstClient)
			
			var secondClient : Node2D = interactedNode.getSecondClient()
			secondClient.get_parent().remove_child(secondClient)
			instatiateClient(secondClient)
			secondClient.flipHImage()
		
	player.setInteractedNode($".")


func instatiateClient(client) -> void:
	clientPositions[clienScenestList.size()].add_child(client)
	clienScenestList.append(client)
	client.setTable($".")
	client.lookAtMenu()
	$ClientLookingMenuTimer.start()


func _on_client_looking_menu_timer_timeout():
	for client in clienScenestList:
		client.askForFood()
		clientsAreWaitingForFood = true


func serveClient(foodNode: Node2D) -> bool:
	if clientsAreWaitingForFood:
		for client in clienScenestList:
			if !client.getIsEating() and client.choosedFood.plate == foodNode.plate:
				client.startEating()
				areClientsWaitingForFood()
				return true
	return false


func areClientsWaitingForFood() -> bool:
	for client in clienScenestList:
		if !client.getIsEating():
			clientsAreWaitingForFood = true
			return clientsAreWaitingForFood
			
	clientsAreWaitingForFood = false
	return clientsAreWaitingForFood


func clientFinishedEating() -> void:
	for client in clienScenestList:
		if !client.getFinishedEating():
			return
			
	leaveClients(true)


func leaveClients(payed : bool):
	for client in clienScenestList:
		client.makeClientInvisible()
	if payed:
		instatiateMoney(moneyScene)
	else:
		cleanTable()

func instatiateMoney(sceneType) -> void:
	var newMoneyScene = sceneType.instantiate()
	$MoneySpawnPoint.add_child(newMoneyScene)
	finishedTable = true


func getIsFinishedTable() -> bool:
	return finishedTable


func cleanTable():
	var numberOfPayments : int = clienScenestList.size()
	var paymentValue = clienScenestList.front().choosedFood.getFoodValue()
	get_tree().root.get_child(0).getPayment(numberOfPayments * paymentValue)
	
	for client in clienScenestList:
		client.get_parent().remove_child(client)
		client.queue_free()
	clienScenestList.clear()
	
	if !$MoneySpawnPoint.get_children().is_empty():
		var moneyChild : Node2D = $MoneySpawnPoint.get_children().front()
		$MoneySpawnPoint.remove_child(moneyChild)
		moneyChild.queue_free()
		
	finishedTable = false

func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func setHighlight(highlight : int) -> void: 
	$TableImage.material.set_shader_parameter("line_thickness",highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$TableImage.material.set_shader_parameter("line_color", color)



