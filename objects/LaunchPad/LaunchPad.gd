extends Area
var exlarate = false
export var maxspeed = 50
export var speedup = 15
export var direction = Vector3(0,1,0)
var curentspeed = Vector3()
func _on_LaunchPad_body_entered(body):
	exlarate = true

func _process(delta):
	if exlarate:
		curentspeed += speedup*direction
		GlobalVars.playervars.EnviermentalMovment += curentspeed
		if abs(curentspeed.x) >=maxspeed:
			exlarate = false
			curentspeed = Vector3.ZERO
		if abs(curentspeed.z) >=maxspeed:
			exlarate = false
			curentspeed = Vector3.ZERO
		if abs(curentspeed.y) >=maxspeed:
			exlarate = false
			curentspeed = Vector3.ZERO
		
