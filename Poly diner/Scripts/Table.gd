extends StaticBody2D

const tableHighlightValue : int = 3

func isBodyPlayer(body) -> bool:
	return body.name == "Player"

func setHighlight(highlight : int) -> void: 
	$TableImage.material.set_shader_parameter("line_thickness",highlight)

func _on_selection_area_body_entered(body):
	if isBodyPlayer(body):
		setHighlight(tableHighlightValue)
	
func _on_selection_area_body_exited(body):
	if isBodyPlayer(body):
		setHighlight(0)
