extends State

@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D

@export var DebugDir : Node3D

@onready var Animator = %AnimationTree

func Enter(Argument):
	Animator.set("parameters/list/transition_request", "HangMovement")
	
func Update(delta):
	_Player.velocity.y = 0
	_Player.Gravity = 0
	_Player.velocity.x = lerp(_Player.velocity.x, 0.0, 0.2)
	_Player.velocity.z = lerp(_Player.velocity.z, 0.0, 0.2)
	Animator.set("parameters/HangMovement/transition_request", "Hanging")
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	if InputDir.normalized():
		_StateMachine.ChangeState(self, "GrabMove", null)
	if !CheckWallCollider.is_colliding() or CheckAirWallCollider.is_colliding():
		_StateMachine.ChangeState(self, "Idle", null)
	if Input.is_action_just_pressed("Jump"):
		CheckWallCollider.enabled = false
		_StateMachine.ChangeState(self, "Jump", null)
		_Player.velocity.y = _Player.JumpSpeed * 1.8
		
func Exit(Argument):
	if _StateMachine.CurrentState.name != "GrabMove":
		Animator.set("parameters/list/transition_request", "BasicMovement")
		_Player.Gravity = _Player.StartGravity
		_Player.JumpSpeed = _Player.StartJumpSpeed
	CheckWallCollider.enabled = true
