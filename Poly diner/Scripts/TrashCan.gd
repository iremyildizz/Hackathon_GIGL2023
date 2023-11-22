extends Node2D

const trashHighlightValue : int = 3
const noHighlightColor : Color = Color(Color.BLACK, 0)
const normalHighlightColor : Color = Color.TURQUOISE

func _on_trash_area_body_entered(body):
	if isBodyPlayer(body):
		setColor(normalHighlightColor)
		setHighlight(trashHighlightValue)
		body.setCurrentSelection($".")


func _on_trash_area_body_exited(body):
	if isBodyPlayer(body):
		setColor(normalHighlightColor)
		setHighlight(0)
		body.setCurrentSelection(null)


func interactWith(interactedNode, player) -> void:
	player.removeAllFood()
	player.setInteractedNode($".")


func isBodyPlayer(body) -> bool:
	return body.name == "Player"


func setHighlight(highlight : int) -> void: 
	$".".material.set_shader_parameter("line_thickness",highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$".".material.set_shader_parameter("line_color", color)
