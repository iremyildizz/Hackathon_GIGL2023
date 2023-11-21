extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$NextDayButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_day_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/EndMenu.tscn")


func _on_next_day_button_mouse_entered():
	$NextDayButton.grab_focus()


func _on_back_button_mouse_entered():
	$BackButton.grab_focus()
