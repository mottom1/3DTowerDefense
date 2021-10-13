extends RigidBody

var Health = 100

func _ready():
	pass


func _process(delta):
	if Health <= 0:
		axis_lock_angular_x = false
		axis_lock_angular_y = false
		axis_lock_angular_z = false
