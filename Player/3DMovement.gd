extends KinematicBody

#CamVars
var LookSensitivity = 1
const CamClap = 90
onready var cambase = $CamBase

#Movement Vars
const MovmentSpeedUp = 4
const AirMovementSpeedUp = .5
var Friction = 4
var MaxPlayerSpeed = 20
var PlayerControledMVector = Vector3()
var wall:bool = false

#VerticalVars
const JumpPower = 3
const MaxJumpPower = 30
var curentJumpPower = 0
const gravity = 2
var YVelo = 2
var Celing:bool = false
var grounded:bool = false 
var CanJump:bool = true

#GunVars
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		cambase.rotation_degrees.x -= event.relative.y * LookSensitivity
		cambase.rotation_degrees.x = clamp(cambase.rotation_degrees.x, -CamClap, CamClap)
		rotation_degrees.y -= event.relative.x * LookSensitivity

func Move():
	
	if Input.is_action_pressed("Forward"):
		if grounded:
			PlayerControledMVector.z += -MovmentSpeedUp-Friction
		else:
			PlayerControledMVector.z += -AirMovementSpeedUp
	else: pass

	if Input.is_action_pressed("Backwards"):
		if grounded:
			PlayerControledMVector.z +=MovmentSpeedUp+Friction
		else:
			PlayerControledMVector.z += +AirMovementSpeedUp
	else: pass

	if Input.is_action_pressed("Right"):
		if grounded:
			PlayerControledMVector.x += MovmentSpeedUp+Friction
		else:
			PlayerControledMVector.x += +AirMovementSpeedUp
	else: pass

	if Input.is_action_pressed("Left"):
		if grounded:
			PlayerControledMVector.x += -MovmentSpeedUp-Friction
		else:
			PlayerControledMVector.x += -AirMovementSpeedUp
	else: pass

	
	
	
	
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
	if GlobalVars.playervars.EnviermentalMovment.z != 0:
		if GlobalVars.playervars.EnviermentalMovment.z < 0:
			GlobalVars.playervars.EnviermentalMovment.z +=Friction
			if GlobalVars.playervars.EnviermentalMovment.z > 0:
				GlobalVars.playervars.EnviermentalMovment.z = 0
		else:
			GlobalVars.playervars.EnviermentalMovment.z -=Friction
			if GlobalVars.playervars.EnviermentalMovment.z < 0:
				GlobalVars.playervars.EnviermentalMovment.z = 0
	if GlobalVars.playervars.EnviermentalMovment.x != 0:
		if GlobalVars.playervars.EnviermentalMovment.x < 0:
			GlobalVars.playervars.EnviermentalMovment.x +=Friction
			if GlobalVars.playervars.EnviermentalMovment.x > 0:
				GlobalVars.playervars.EnviermentalMovment.x = 0
		else:
			GlobalVars.playervars.EnviermentalMovment.x -=Friction
			if GlobalVars.playervars.EnviermentalMovment.x < 0:
				GlobalVars.playervars.EnviermentalMovment.x = 0


	if GlobalVars.playervars.EnviermentalMovment.y != 0:
		if GlobalVars.playervars.EnviermentalMovment.y < 0:
			GlobalVars.playervars.EnviermentalMovment.y +=gravity
			if GlobalVars.playervars.EnviermentalMovment.y > 0:
				GlobalVars.playervars.EnviermentalMovment.y = 0
		else:
			GlobalVars.playervars.EnviermentalMovment.y -=gravity
			if GlobalVars.playervars.EnviermentalMovment.y < 0:
				GlobalVars.playervars.EnviermentalMovment.y = 0


func VerticalMovment():
	if grounded:
		YVelo = -0.01
		CanJump = true
		
	else:
		YVelo -= gravity
	if Celing:
		YVelo = 0.1
		CanJump = false
	
	if Input.is_action_pressed("Jump") and CanJump:
		YVelo += JumpPower +gravity


	if Input.is_action_just_released("Jump"):
		CanJump = false
	
	if YVelo > MaxJumpPower:
		CanJump = false



func _physics_process(_delta):
	Move()
	VerticalMovment()
	move_and_slide(GlobalVars.playervars.EnviermentalMovment+ PlayerControledMVector.rotated(Vector3(0,1,0), rotation.y) + Vector3(0,YVelo,0), Vector3.UP)
	if Input.is_action_just_pressed("menue"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	Celing = is_on_ceiling()
	grounded = is_on_floor()
	wall = is_on_wall()



