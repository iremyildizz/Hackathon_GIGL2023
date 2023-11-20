extends CharacterBody2D

const speed : int = 500
var currentSelection : Node2D = null
var interactedNode : Node2D = null

const interactedHighlightColor : Color = Color.RED

func _process(_delta):
	move()
	handleAction()
	print(interactedNode)


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
	interactedNode = nodeInteracted
	if interactedNode.has_method("setColor"):
		interactedNode.setColor(interactedHighlightColor)


func isAnInteractedNode(nodeCompare: Node2D) -> bool:
	return nodeCompare != null and nodeCompare == interactedNode
