extends Node2D

func initPoutine() -> void:
	$Poutine.visible = true
	

func initIceCream() -> void:
	$IceCream.visible = true


func setHighlight(highlight : int) -> void: 
	$".".material.set_shader_parameter("line_thickness", highlight)


func setColor(color: Color) -> void: 
	$".".material.set_shader_parameter("line_color", color)
