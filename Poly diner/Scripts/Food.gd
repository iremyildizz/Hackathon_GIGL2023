extends Node2D

enum Plates {POUTINE = 0, ICE_CREAM = 1, MILK_SHAKE = 2, BURGER = 3, SHRIMP = 4}

const possiblesVlues : int = 5
var plate : int = 0
var image : Node2D = null
var foodValue : int = 20
const foodLostValue : int = 3

func setRandomizedPlate() -> void:
	var randomValue = randi() % possiblesVlues
	setPlate(randomValue)


func setPlate(plateValue : int) -> void:
	if plateValue == Plates.POUTINE:
		image = $Poutine
	if plateValue == Plates.ICE_CREAM:
		image = $IceCream
	if plateValue == Plates.MILK_SHAKE:
		image = $MilkShake
	if plateValue == Plates.BURGER:
		image = $Burger
	if plateValue == Plates.SHRIMP:
		image = $Shrimp
	
	image.visible = true	
	plate = plateValue


func clearPlate() -> void:
	image.visible = false


func makePlateDirty() -> void:
	$CleanPlate.visible = false
	$DirtyPlate.visible = true

func setHighlight(highlight : int) -> void: 
	$".".material.set_shader_parameter("line_thickness", highlight)


func setColor(color: Color) -> void: 
	if color != Color.RED:
		$".".material.set_shader_parameter("line_color", color)


func interactWith(interactedNode, player) -> void:
	player.setInteractedNode($".")


func reduceFoodValue():
	foodValue -= foodLostValue


func getFoodValue() -> int:
	return foodValue
