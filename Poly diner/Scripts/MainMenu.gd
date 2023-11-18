extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartGameButton.grab_focus()

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Options.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

