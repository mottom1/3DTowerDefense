extends KinematicBody

var Health = 100

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Health <= 0:
		queue_free()
