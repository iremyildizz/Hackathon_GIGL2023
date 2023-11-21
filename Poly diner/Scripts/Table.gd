extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")
@onready var clientPositions : Array[Node2D] = [$ClientPlacesPoints/FirstPlace, $ClientPlacesPoints/SecondPlace]

var clienScenestList : Array[Node2D] = []

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
	if interactedNode.has_method("getIsSingleClient") and clienScenestList.size() == 0:
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


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func setHighlight(highlight : int) -> void: 
	$TableImage.material.set_shader_parameter("line_thickness",highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$TableImage.material.set_shader_parameter("line_color", color)



