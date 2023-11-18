extends CharacterBody2D

const speed : int = 500

func _process(_delta):
	move()

func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# if Input.is_action_pressed("primary action"):
	# 	print("action")
