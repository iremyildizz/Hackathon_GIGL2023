extends Timer

onready var timer = get_node($".")
onready var pb = get_node($"../TextureProgressBar")

# Called when the node enters the scene tree for the first time.
func _ready():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	pass # Replace with function body.
