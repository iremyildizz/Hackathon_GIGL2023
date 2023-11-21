extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.max_value = int($GameTimer.wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$sec.set_text(str(int($GameTimer.time_left)))
	$TextureProgressBar.value = int($GameTimer.time_left)


func _on_game_timer_timeout():
	pass
	

func _on_texture_progress_bar_value_changed(value):
	pass
