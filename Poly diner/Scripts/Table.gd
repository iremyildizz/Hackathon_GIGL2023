extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func isBodyPlayer(body) -> bool:
	return body.name == "Player"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_selection_area_body_entered(body):
	if isBodyPlayer(body):
		print("Entered")
	
func _on_selection_area_body_exited(body):
	if isBodyPlayer(body):
		print("Exit")
