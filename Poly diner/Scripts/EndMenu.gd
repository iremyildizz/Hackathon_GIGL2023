extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_next_day_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")
	
	
func _on_upgrades_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Upgrades.tscn")

	
func _on_main_menu_button_mouse_entered():
	$MainMenuButton.grab_focus()


func _on_quit_button_mouse_entered():
	$QuitButton.grab_focus()


func _on_next_day_button_mouse_entered():
	$NextDayButton.grab_focus()


func _on_upgrades_menu_button_mouse_entered():
	$UpgradesMenuButton.grab_focus()
