extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")
@onready var clientPositions : Array[Node2D] = [$SpawnContainer/FirstLine, $SpawnContainer/SecondLine, $SpawnContainer/ThridLine]

var clienScenestList : Array[Node2D] = []
const maxClientScenes : int = 3
const clientHighlightValue : int = 3

func _ready():
	pass

func _on_line_selection_area_body_entered(body):
	selectFrontClients(body, clientHighlightValue)

func _on_line_selection_area_body_exited(body):
	selectFrontClients(body, 0)
			
func selectFrontClients(body: Node2D, highlight : int) -> void: 
	if isBodyPlayer(body):
		if clienScenestList.size() > 0:
			var firstClient = clienScenestList.front()
			firstClient.setHighlight(highlight)
			
func isBodyPlayer(body) -> bool:
	return body.name == "Player"

func _on_new_client_timer_timeout():
	if clienScenestList.size() < maxClientScenes:
		addNewClientToQueue()
	else : 
		$NewClientTimer.stop()
		
func addNewClientToQueue() -> void:
	var newClientScene = clientScene.instantiate()
	clientPositions[clienScenestList.size()].add_child(newClientScene)
	clienScenestList.append(newClientScene)
	
func popClientFromQueue() -> void:
	if clienScenestList.size() == 0:
		return
		
	var firstClient = clienScenestList.pop_front()
	firstClient.queue_free()
	advanceQueue()
	$NewClientTimer.start()
	
func advanceQueue() -> void:
	for i in range(0, clienScenestList.size(), 1) :
		clienScenestList[i].get_parent().remove_child(clienScenestList[i])
		clientPositions[i].add_child(clienScenestList[i])
	
