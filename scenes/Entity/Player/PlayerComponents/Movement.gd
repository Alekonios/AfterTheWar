
class_name Movement
extends CharacterBody3D

@export var _Components : Components

@export_category("Stats")
@export var StartSpeed : float = 2.0
@export var StartJump : float = 3.0
@export var StartGravity = 2
@export var RunSpeed : float = 2.0

var Speed : float
var JumpVel : float
var Gravity : float

@export_category("Nodes")
@export var Model : Node3D
@export var DebugMoveVis : Node3D
@export var FloorJumpTimer : Timer

var IsRunning = false
var WantJump = true
var is_walking: bool = false

func _ready() -> void:
	Speed = StartGravity
	JumpVel = StartJump
	Gravity = StartGravity
	RunSpeed = StartSpeed * RunSpeed

func _physics_process(delta: float) -> void:
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	var Direction = (transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	_Components._StateMachine.State = _Components._StateMachine.States.BasicMovement
	if Input.is_action_pressed("Run") and InputDir:
		Speed = lerp(Speed, RunSpeed, 0.1)
		IsRunning = true
		_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Run
	else:
		Speed = lerp(Speed, StartSpeed, 0.1)
		IsRunning = false
		
	if Direction:
		velocity.x = lerp(velocity.x, Direction.x * Speed, 0.2)
		velocity.z = lerp(velocity.z, -Direction.z * Speed, 0.2)
		DebugMoveVis.look_at(Direction + position)
		Model.rotation.y = lerp_angle(Model.rotation.y, -DebugMoveVis.rotation.y, 0.2)
		is_walking = true
		if !IsRunning:
			_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Walk
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		velocity.z = lerp(velocity.z, 0.0, 0.2)
		is_walking = false
		if !IsRunning:
			_Components._StateMachine.Condition = _Components._StateMachine.BasicMovementStates.Idle


	if WantJump:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JumpVel
			_Components._StateMachine.Jump()
			velocity.x = lerp(velocity.x, Direction.x * 5, 1)
			velocity.z = lerp(velocity.z, -Direction.z * 5, 1)
		
	if is_on_floor() and !WantJump:
		WantJump = true
		
	elif WantJump and FloorJumpTimer.is_stopped():
		FloorJumpTimer.start()
	
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_floor_jump_time_timeout() -> void:
	WantJump = false
