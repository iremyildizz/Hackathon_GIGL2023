extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")
@onready var clientPositions : Array[Node2D] = [$ClientPlacesPoints/FirstPlace, $ClientPlacesPoints/SecondPlace]

var clienScenestList : Array[Node2D] = []

const tableHighlightValue : int = 3

func _on_selection_area_body_entered(body):
	if isBodyPlayer(body):
		setHighlight(tableHighlightValue)
		body.setCurrentSelection($".")


func _on_selection_area_body_exited(body):
	if isBodyPlayer(body):
		setHighlight(0)
		body.setCurrentSelection(null)

func interactWith(interactedNode, player) -> void:
	if interactedNode.has_method("getIsSingleClient") and clienScenestList.size() == 0:
		get_tree().root.get_child(0).placeFirstClientInLine()
		
		if interactedNode.getIsSingleClient():
			instatiateClient(interactedNode)
		else:
			interactedNode.setClientsTransformToOrigin()
			
			var firstClient : Node2D = interactedNode.getFirstClient()
			firstClient.get_parent().remove_child(firstClient)
			instatiateClient(firstClient)
			
			var secondClient : Node2D = interactedNode.getSecondClient()
			secondClient.get_parent().remove_child(secondClient)
			instatiateClient(secondClient)
		
	player.setInteractedNode($".")


func instatiateClient(client) -> void:
	clientPositions[clienScenestList.size()].add_child(client)
	clienScenestList.append(client)


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func setHighlight(highlight : int) -> void: 
	$TableImage.material.set_shader_parameter("line_thickness",highlight)
