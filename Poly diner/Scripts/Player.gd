extends CharacterBody2D

const speed : int = 500
var currentSelection : Node2D = null

func _process(_delta):
	move()


func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	handleAction()


func handleAction() -> void:
	if Input.is_action_just_pressed("primary action"):
		print(currentSelection)
