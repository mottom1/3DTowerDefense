extends KinematicBody

#CamVars
var LookSensitivity = .7
const CamClap = 90
onready var cambase = $CamBase

#Movement Vars
const MovmentSpeedUp = 4
const AirMovementSpeedUp = .1
var Friction = 2.5

var MaxPlayerSpeed = 10
var OGMaxPlayerSpeed = MaxPlayerSpeed
var RealMaxPlayerSpeed = 22
var MaxSpeedUp = .1
var MaxSpeedDown = MaxSpeedUp
var PlayerControledMVector = Vector3()
var EnviermentContrlVector : Vector3
var wall:bool = false

#VerticalVars
const JumpPower = 3
const MaxJumpPower = 30
var curentJumpPower = 0
const gravity = 1.6
var YVelo = 2
var YVeloCap = 80
var Celing:bool = false
var grounded:bool = false 
var CanJump:bool = true
var getsnap = Vector3(0,-5,0)
var snap = Vector3(0,-5,0)
# Shop Vars
var Coins = 0
#GunVars
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



#Mouse Movment
func _input(event):
	if event is InputEventMouseMotion:
		cambase.rotation_degrees.x -= event.relative.y * LookSensitivity
		cambase.rotation_degrees.x = clamp(cambase.rotation_degrees.x, -CamClap, CamClap)
		rotation_degrees.y -= event.relative.x * LookSensitivity


func Move():
	
	if Input.is_action_pressed("Forward"):
		if grounded:
			PlayerControledMVector += Vector3(0,0,-MovmentSpeedUp-Friction).rotated(Vector3(0,1,0), rotation.y)
			

		else:
			PlayerControledMVector += Vector3(0,0,-AirMovementSpeedUp).rotated(Vector3(0,1,0), rotation.y)
	else: pass

	if Input.is_action_pressed("Backwards"):
		if grounded:
			PlayerControledMVector +=Vector3(0,0,MovmentSpeedUp+Friction).rotated(Vector3(0,1,0), rotation.y)
		else:
			PlayerControledMVector += Vector3(0,0,AirMovementSpeedUp).rotated(Vector3(0,1,0), rotation.y)
	else: pass

	if Input.is_action_pressed("Right"):
		if grounded:
			PlayerControledMVector += Vector3(MovmentSpeedUp+Friction,0,0).rotated(Vector3(0,1,0), rotation.y)
		else:
			PlayerControledMVector += Vector3(AirMovementSpeedUp,0,0).rotated(Vector3(0,1,0), rotation.y)
	else: pass

	if Input.is_action_pressed("Left"):
		if grounded:
			PlayerControledMVector += Vector3(-MovmentSpeedUp-Friction,0,0).rotated(Vector3(0,1,0), rotation.y)
		else:
			PlayerControledMVector += Vector3(-AirMovementSpeedUp,0,0).rotated(Vector3(0,1,0), rotation.y)
	else: pass
	
	
	if MaxPlayerSpeed >= RealMaxPlayerSpeed:
		MaxPlayerSpeed = RealMaxPlayerSpeed
		
	if Input.is_action_just_pressed("Backwards") or Input.is_action_pressed("Forward") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		if !wall:
			MaxPlayerSpeed += MaxSpeedUp +MaxSpeedDown
		else: MaxPlayerSpeed = OGMaxPlayerSpeed
		
	if MaxPlayerSpeed > OGMaxPlayerSpeed:
		MaxPlayerSpeed -= MaxSpeedDown
		
		if PlayerControledMVector != Vector3(0,0,0):
			pass
		else:
			MaxPlayerSpeed = OGMaxPlayerSpeed
	
	if wall:
		EnviermentContrlVector.x = 0
		EnviermentContrlVector.z = 0
	
#	SlowsPlayerControledMVector
	if PlayerControledMVector.z != 0:
		if PlayerControledMVector.z < 0 and grounded:
			PlayerControledMVector.z +=Friction
			if PlayerControledMVector.z > 0:
				PlayerControledMVector.z = 0
		if PlayerControledMVector.z <= -MaxPlayerSpeed:
			PlayerControledMVector.z = -MaxPlayerSpeed

		if PlayerControledMVector.z > 0 and grounded:
			PlayerControledMVector.z -=Friction
			if PlayerControledMVector.z < 0:
				PlayerControledMVector.z = 0
		if PlayerControledMVector.z >= MaxPlayerSpeed:
			PlayerControledMVector.z = MaxPlayerSpeed
	if PlayerControledMVector.x != 0:
		if PlayerControledMVector.x < 0 and grounded:
			PlayerControledMVector.x +=Friction
			if PlayerControledMVector.x > 0:
				PlayerControledMVector.x = 0
			if PlayerControledMVector.x <= -MaxPlayerSpeed:
				PlayerControledMVector.x = - MaxPlayerSpeed
		if PlayerControledMVector.x > 0 and grounded:
			PlayerControledMVector.x -=Friction
			if PlayerControledMVector.x < 0:
				PlayerControledMVector.x = 0
			if PlayerControledMVector.x >= MaxPlayerSpeed:
				PlayerControledMVector.x = MaxPlayerSpeed

#	SlowsDownMVector
	if EnviermentContrlVector.z != 0:
		if EnviermentContrlVector.z < 0:
			EnviermentContrlVector.z +=Friction
			if EnviermentContrlVector.z > 0:
				EnviermentContrlVector.z = 0
		else:
			EnviermentContrlVector.z -=Friction
			if EnviermentContrlVector.z < 0:
				EnviermentContrlVector.z = 0
	if EnviermentContrlVector.x != 0:
		if EnviermentContrlVector.x < 0:
			EnviermentContrlVector.x +=Friction
			if EnviermentContrlVector.x > 0:
				EnviermentContrlVector.x = 0
		else:
			EnviermentContrlVector.x -=Friction
			if EnviermentContrlVector.x < 0:
				EnviermentContrlVector.x = 0
	if EnviermentContrlVector.y != 0:
		if EnviermentContrlVector.y < 0:
			EnviermentContrlVector.y +=gravity
			if EnviermentContrlVector.y > 0:
				EnviermentContrlVector.y = 0
		else:
			EnviermentContrlVector.y -=gravity
			if EnviermentContrlVector.y < 0:
				EnviermentContrlVector.y = 0


func VerticalMovment():
	if grounded:
		YVelo = -0.01
		CanJump = true
		
	else:
		YVelo -= gravity
	if Celing:
		YVelo = -0.4
		CanJump = false
		EnviermentContrlVector.y = EnviermentContrlVector.y *2/3
	
	if YVelo <-YVeloCap:
		YVelo = -YVeloCap
	
	snap.y = move_toward(snap.y, getsnap.y, .5)
	
	if Input.is_action_pressed("Jump") and CanJump:
		snap = Vector3.ZERO
		YVelo += JumpPower +gravity


	if Input.is_action_just_released("Jump"):
		CanJump = false
	
	if YVelo > MaxJumpPower:
		CanJump = false
		



func _physics_process(_delta):
	Move()
	VerticalMovment()
	move_and_slide_with_snap(EnviermentContrlVector+ PlayerControledMVector + Vector3(0,YVelo,0),snap, Vector3.UP,false, 4, .785398, false)
	var Menue = false
	if Input.is_action_just_pressed("menue"):
		if !Menue:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
			Menue = true
		elif Menue: 
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Menue = !Menue
	
	Celing = is_on_ceiling()
	grounded = is_on_floor()
	wall = is_on_wall()

