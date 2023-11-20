extends Node2D

func setHighlight(highlight : int) -> void: 
	$ClientImage.material.set_shader_parameter("line_thickness", highlight)


func setColor(color : Color) -> void: 
	$ClientImage.material.set_shader_parameter("line_color", color)


func flipHImage() -> void :
	$ClientImage.flip_h = true
