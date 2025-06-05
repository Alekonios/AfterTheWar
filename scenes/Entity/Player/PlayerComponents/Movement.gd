class_name Player

extends CharacterBody3D

@export var _Components : Components

@export_category("Setting")
@export var MaxSpeed : float = 4.0
@export var StartSpeed : float = 2.0
@export var StartGrabSpeed : float = 0.5
@export var CrouchRatio : float = 0.5
@export var RunRatio : float = 2.0
@export var StartGravity : float = 2.0
@export var StartJumpSpeed : float = 6.0

@export_category("SharedVariables")
@export var Speed : float
@export var GrabSpeed : float 
@export var CrouchSpeed : float
@export var RunSpeed : float
@export var Gravity : float
@export var JumpSpeed : float

func _ready() -> void:
	Speed = StartSpeed
	RunSpeed = Speed * RunRatio
	Gravity = StartGravity
	JumpSpeed = StartJumpSpeed
	GrabSpeed = StartGrabSpeed
	
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta * Gravity
		
	move_and_slide()
	%FpsLabel.text = str(Engine.get_frames_per_second())


#@export var _Components : Components
#
#@export_category("Stats")
#@export var StartSpeed : float = 2.0
#@export var StartJump : float = 6.0
#@export var StartGravity = 2
#@export var RunSpeed : float = 2.0
#
#var Speed : float
#var JumpVel : float
#var Gravity : float
#
#@export_category("Nodes")
#@export var Model : Node3D
#@export var DebugMoveVis : Node3D
#@export var FloorJumpTimer : Timer
#
#var IsRunning = false
#var WantJump = true
#var is_walking: bool = false
#
#func _ready() -> void:
	#Speed = StartGravity
	#JumpVel = StartJump
	#Gravity = StartGravity
	#RunSpeed = StartSpeed * RunSpeed
#
#func _physics_process(delta: float) -> void:
	#var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	#var Direction = (transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	##_Components._StateMachine.State = _Components._StateMachine.States.BasicMovement
	#if Input.is_action_pressed("Run") and InputDir:
		#Speed = lerp(Speed, RunSpeed, 0.1)
		#IsRunning = true
		##_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Run
	#else:
		#Speed = lerp(Speed, StartSpeed, 0.1)
		#IsRunning = false
		#
	#if Direction:
		#velocity.x = lerp(velocity.x, Direction.x * Speed, 0.2)
		#velocity.z = lerp(velocity.z, -Direction.z * Speed, 0.2)
		#DebugMoveVis.look_at(Direction + position)
		#Model.rotation.y = lerp_angle(Model.rotation.y, -DebugMoveVis.rotation.y, 0.2)
		#is_walking = true
		##if !IsRunning:
			##_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Walk
	#else:
		#velocity.x = lerp(velocity.x, 0.0, 0.2)
		#velocity.z = lerp(velocity.z, 0.0, 0.2)
		#is_walking = false
		##if !IsRunning:
			##_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Idle
#
#
