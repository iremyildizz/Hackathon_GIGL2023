extends CharacterBody2D

var currentSelection : Node2D = null
var interactedNode : Node2D = null
@onready var currentImage : Sprite2D = $PlayerImage

var grabbedFoodList : Array[Node2D] = []

const speed : int = 500
const maxGrabbedFood : int = 2
const noHighlightColor : Color = Color(Color.BLACK, 0)
const normalHighlightColor : Color = Color.TURQUOISE
const interactedHighlightColor : Color = Color.RED


func _process(_delta):
	move()
	handleAction()


func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()


func handleAction() -> void:
	if Input.is_action_just_pressed("primary action"):
		if currentSelection == null:
			return
		
		if interactedNode != null:
			interactNodes()
			return
		
		setInteractedNode(currentSelection)


func interactNodes() -> void:
	if currentSelection == interactedNode:
		return
	currentSelection.interactWith(interactedNode, $".")


func setCurrentSelection(nodeSelected: Node2D) -> void:
	currentSelection = nodeSelected


func setInteractedNode(nodeInteracted: Node2D) -> void:
	if interactedNode != null:
		if interactedNode.has_method("setColor"):
			interactedNode.setColor(noHighlightColor)
	
	interactedNode = nodeInteracted
	if interactedNode.has_method("setColor"):
		interactedNode.setColor(interactedHighlightColor)
	
	if interactedNodeIsfoodPlate():
		takeFood(interactedNode)
	
	if interactedNodeIsTablePlate():
		serveTable(interactedNode)


func isAnInteractedNode(nodeCompare: Node2D) -> bool:
	return nodeCompare != null and nodeCompare == interactedNode


func interactedNodeIsTablePlate() -> bool:
	return interactedNode != null and interactedNode.has_method("serveClient")


func interactedNodeIsfoodPlate() -> bool:
	return interactedNode != null and interactedNode.name == "Food"


func takeFood(foodNode : Node2D) -> void:
	if grabbedFoodList.size() < maxGrabbedFood:
		var firstPlate = grabbedFoodList.front()
		if firstPlate == null:
			addGrabbedFood(foodNode, $FirstPlateSpawnPoint, $PlayerWithOnePlate)
		else:
			addGrabbedFood(foodNode, $SecondPlateSpawnPoint, $PlayerWithTwoPlates)


func addGrabbedFood(foodNode: Node2D, placementNode: Node2D, imageNode: Node2D) -> void:
	get_tree().root.get_child(0).takeCounterFood(foodNode)
	foodNode.get_parent().remove_child(foodNode)
	placementNode.add_child(foodNode)
	foodNode.setColor(noHighlightColor)
	
	currentImage.visible = false
	currentImage = imageNode
	currentImage.visible = true
	
	grabbedFoodList.append(foodNode)
	
	interactedNode = null


func serveTable(table: Node2D) -> void:
	if grabbedFoodList.size() > 0:
		for food in grabbedFoodList:
			if table.serveClient(food):
				grabbedFoodList.erase(food)
				serveTable(table)
