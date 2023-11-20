extends CharacterBody2D

const speed : int = 500
var currentSelection : Node2D = null
var interactedNode : Node2D = null

const interactedHighlightColor : Color = Color.RED

func _process(_delta):
	move()


func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	handleAction()


func handleAction() -> void:
	if Input.is_action_just_pressed("primary action"):
		if currentSelection == null:
			return
		
		interactedNode = currentSelection
		interactedNode.setColor(interactedHighlightColor)


func setCurrentSelection(nodeSelected: Node2D) -> void:
	currentSelection = nodeSelected


func isAnInteractedNode(nodeCompare: Node2D) -> bool:
	return nodeCompare != null and nodeCompare == interactedNode
