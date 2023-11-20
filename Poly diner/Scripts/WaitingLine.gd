extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")
var doubleClientScene = preload("res://Scenes/DoubleClient.tscn")
@onready var clientPositions : Array[Node2D] = [$SpawnContainer/FirstLine, $SpawnContainer/SecondLine, $SpawnContainer/ThirdLine]

var clientScenesList : Array[Node2D] = []

var doubleClientProbablility : int = 50
const maxProbabilityValue : int = 100

const maxClientScenes : int = 3
const clientHighlightValue : int = 3


func _ready():
	pass


func _on_line_selection_area_body_entered(body):
	selectFrontClients(body, clientHighlightValue, true)


func _on_line_selection_area_body_exited(body):	
	selectFrontClients(body, 0, false)


func selectFrontClients(body: Node2D, highlight : int, isSelected: bool) -> void: 
	if isBodyPlayer(body) and clientScenesList.size() > 0:
		var firstClient : Node2D = clientScenesList.front()
		
		if !body.isAnInteractedNode(firstClient):
			firstClient.setHighlight(highlight)
		
		if isSelected:
			body.setCurrentSelection(firstClient)
		else:
			body.setCurrentSelection(null)


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func _on_new_client_timer_timeout():
	if clientScenesList.size() < maxClientScenes:
		addNewClientToQueue()
	else : 
		$NewClientTimer.stop()


func addNewClientToQueue() -> void:
	var randomValue = randi() % maxProbabilityValue + 1
	if randomValue <= doubleClientProbablility:
		instatiateClients(doubleClientScene)
	else:
		instatiateClients(clientScene)


func instatiateClients(sceneType) -> void:
	var newClientScene = sceneType.instantiate()
	clientPositions[clientScenesList.size()].add_child(newClientScene)
	clientScenesList.append(newClientScene)


func popClientFromQueue() -> void:
	if clientScenesList.size() == 0:
		return

	var firstClient = clientScenesList.pop_front()
	firstClient.get_parent().remove_child(firstClient)

	advanceQueue()
	$NewClientTimer.start()


func advanceQueue() -> void:
	for i in range(0, clientScenesList.size(), 1) :
		clientScenesList[i].get_parent().remove_child(clientScenesList[i])
		clientPositions[i].add_child(clientScenesList[i])

