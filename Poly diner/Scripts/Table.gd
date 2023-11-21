extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")
@onready var clientPositions : Array[Node2D] = [$ClientPlacesPoints/FirstPlace, $ClientPlacesPoints/SecondPlace]

var clienScenestList : Array[Node2D] = []
var clientsAreWaitingForFood = false

const tableHighlightValue : int = 3
const noHighlightColor : Color = Color(Color.BLACK, 0)
const normalHighlightColor : Color = Color.TURQUOISE

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
	client.lookAtMenu()
	$ClientLookingMenuTimer.start()


func _on_client_looking_menu_timer_timeout():
	for client in clienScenestList:
		client.askForFood()
		clientsAreWaitingForFood = true


func serveClient(foodNode: Node2D) -> bool:
	if clientsAreWaitingForFood:
		for client in clienScenestList:
			if client.choosedFood.plate == foodNode.plate:
				clienScenestList.erase(client)
				return true
	return false


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func setHighlight(highlight : int) -> void: 
	$TableImage.material.set_shader_parameter("line_thickness",highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$TableImage.material.set_shader_parameter("line_color", color)



