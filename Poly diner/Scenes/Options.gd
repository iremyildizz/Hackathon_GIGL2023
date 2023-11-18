extends Control

func _ready():
	pass # Replace with function body.

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
