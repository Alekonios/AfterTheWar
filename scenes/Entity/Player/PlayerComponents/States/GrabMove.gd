extends State

@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D

@export var DebugDir : Node3D

@onready var Animator = %AnimationTree

func Enter(Argument):
	Animator.set("parameters/list/transition_request", "HangMovement")

func _physics_process(delta: float) -> void:
	if _StateMachine.CurrentState.name.to_lower() != StateName.to_lower():
		return
	_Player.velocity.y = 0
	_Player.Gravity = 0
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	var Direction = (_Player.transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	var Dir = Vector3(0, 0, -1).rotated(Vector3.UP, DebugDir.global_rotation.y)
	if InputDir:
		_Player.Speed = lerp(_Player.Speed, _Player.GrabSpeed, 0.2)
		if Direction.z > 0:
			_Player.velocity = lerp(_Player.velocity, Dir * _Player.Speed, 0.2)
			Animator.set("parameters/HangMovement/transition_request", "GrabRight")
		elif Direction.z < 0:
			_Player.velocity = lerp(_Player.velocity, -Dir * _Player.Speed, 0.2)
			Animator.set("parameters/HangMovement/transition_request", "GrabLeft")
	else:
		_StateMachine.ChangeState(self, "GrabIdle", null)
		
	if !CheckWallCollider.is_colliding() and !CheckAirWallCollider.is_colliding():
		_Player.Gravity = _Player.StartGravity
		_StateMachine.ChangeState(self, "Idle", null)
	if Input.is_action_just_pressed("Jump"):
		_Player.Gravity = _Player.StartGravity
		_StateMachine.ChangeState(self, "Jump", null)
		
	
func Update(delta):
	pass
		
func Exit(Argument):
	Animator.set("parameters/list/transition_request", "BasicMovement")
