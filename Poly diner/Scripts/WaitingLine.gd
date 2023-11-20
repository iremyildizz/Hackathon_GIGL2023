extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")

var clienScenestList = []
const clientHighlightValue : int = 3

func _ready():
	var newClientScene = clientScene.instantiate()
	clienScenestList.append(newClientScene)
	add_child(newClientScene)
	#newClientScene.setHighlight(0)
	
func isBodyPlayer(body) -> bool:
	return body.name == "Player"

func _on_line_selection_area_body_entered(body):
	selectFrontClients(body, clientHighlightValue)

func _on_line_selection_area_body_exited(body):
	selectFrontClients(body, 0)
			
func selectFrontClients(body: Node2D, highlight : int) -> void: 
	if isBodyPlayer(body):
		if clienScenestList.size() > 0:
			var firstClient = clienScenestList.front()
			firstClient.setHighlight(highlight)
