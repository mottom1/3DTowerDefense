extends Spatial
var damadge = 10
onready var ARAnimation = $Hand/AR/AnimationPlayer
onready var Raycast = $LookAtTheShote
var Bullets := 12
var reloadbullets := 12
var curentgun : String = "AR"
var allreadystarted :bool = false




func _physics_process(delta):
	if Input.is_action_pressed("Shoot") and !allreadystarted:
		if Bullets >0:
			FireAR()
		else:
			allreadystarted = true
			ARAnimation.play("Reload")
			print(str(Bullets))
			yield(ARAnimation, "animation_finished")
			Bullets = reloadbullets
			
			allreadystarted = false
		
	if Input.is_action_just_released("Shoot") and !allreadystarted:
		ARAnimation.stop()

func FireAR():
	
		if not ARAnimation.is_playing():
			Bullets -= 1
			if Raycast.is_colliding():
				var target = Raycast.get_collider() 
				if target.is_in_group("Enimes"):
					if target.is_in_group("Enimes"):
						target.Health -= damadge
						
		ARAnimation.play("Shoot")
	
	


	
	
	
