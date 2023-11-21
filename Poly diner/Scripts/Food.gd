extends Node2D

enum Plates {POUTINE = 0, ICE_CREAM = 1}

const possiblesVlues : int = 2
var plate : int = 0


func setRandomizedPlate() -> void:
	var randomValue = randi() % possiblesVlues
	setPlate(randomValue)


func setPlate(plateValue : int) -> void:
	if plateValue == Plates.POUTINE:
		initPoutine()
	if plateValue == Plates.ICE_CREAM:
		initIceCream()
		
	plate = plateValue


func initPoutine() -> void:
	$Poutine.visible = true


func initIceCream() -> void:
	$IceCream.visible = true


func setHighlight(highlight : int) -> void: 
	$".".material.set_shader_parameter("line_thickness", highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$".".material.set_shader_parameter("line_color", color)


func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")
