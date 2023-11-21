extends Node2D

@export var minutes : int = 0
@export var seconds : int = 0
var dsec : int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	if minutes > 0 and seconds <= 0: 
		minutes -= 1
		seconds = 60
	
	if seconds >= 10:
		$sec.set_text(str(seconds))
	else:
		$sec.set_text("0" + str(seconds))
	if minutes >= 10:
		$sec.set_text(str(minutes))
	else:
		$sec.set_text("0" + str(minutes))
		
		


func _on_game_timer_timeout():
	dsec -= 1
