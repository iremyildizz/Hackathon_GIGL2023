extends Node2D

func setHighlight(highlight : int) -> void: 
	$ClientImage.material.set_shader_parameter("line_thickness",highlight)

