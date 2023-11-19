extends StaticBody2D

var clientScene = preload("res://Scenes/Client.tscn")

var clienScenestList = []

func _ready():
	var newClientScene = clientScene.instantiate()
	clienScenestList.append(newClientScene)
	add_child(newClientScene)
	newClientScene.setHighlight(0)
	


