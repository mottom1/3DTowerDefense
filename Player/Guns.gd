extends Spatial
var damadge = 10
onready var ARAnimation = $Hand/AR/AnimationPlayer
onready var Raycast = $LookAtTheShote

var curentgun : String = "AR"
	
func FireAR():

	if not ARAnimation.is_playing():
			if Raycast.is_colliding():
				var target = Raycast.get_collider() 
				if target.is_in_group("Enimes"):
					if target.is_in_group("Enimes"):
						target.Health -= damadge
						print(str(target.Health))
	ARAnimation.play("Shoot")
	
	

func _physics_process(delta):
	if Input.is_action_pressed("Shoot"):
			FireAR()
	if Input.is_action_just_released("Shoot"):
		ARAnimation.stop()
