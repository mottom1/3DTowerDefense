extends Spatial
var damadge = 10
onready var ARAnimation = $Hand/AR/AnimationPlayer
onready var Raycast = $LookAtTheShote
var Bullets := 12
var reloadbullets := 12
var curentgun : String = "AR"
onready var ReloadTimer = $ReloadTimer
var reloadtime :float = 1.0
var allreadystarted :bool = false
func _ready():
	ReloadTimer.wait_time = reloadtime

func FireAR():
	
		if not ARAnimation.is_playing():
			Bullets -= 1
			if Raycast.is_colliding():
				var target = Raycast.get_collider() 
				if target.is_in_group("Enimes"):
					if target.is_in_group("Enimes"):
						target.Health -= damadge
						print(str(target.Health))
		ARAnimation.play("Shoot")
	
	

func _physics_process(delta):
	if Input.is_action_pressed("Shoot"):
		if Bullets >0:
			FireAR()
		elif !allreadystarted:
			ReloadTimer.start()
			allreadystarted = true
		
	if Input.is_action_just_released("Shoot"):
		ARAnimation.stop()


func _on_ReloadTimer_timeout():
	allreadystarted = false
	Bullets = reloadbullets
	print("Reloaded")
