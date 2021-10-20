extends Area

export var speed = 120

export var direction = Vector3(0,1,0)
var curentspeed = Vector3()
var Player


func _on_LaunchPad_body_entered(body):
	var Class = body.get_class()
	if body.is_in_group("Player"):
		Player = body
		LaunchPlayer()
	elif body.is_class("RigidBody"):
		body.add_central_force(direction*speed*50)
	
func LaunchPlayer():
	Player.EnviermentContrlVector += direction*speed
	Player.YVelo = 0
	print(str(Player.EnviermentContrlVector))
