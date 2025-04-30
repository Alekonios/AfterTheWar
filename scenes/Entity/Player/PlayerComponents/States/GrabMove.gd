extends State

@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D

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
	if InputDir:
		_Player.velocity.x = lerp(_Player.velocity.x, Direction.x * _Player.Speed, 0.2)
		if Direction.x < 0:
			Animator.set("parameters/HangMovement/transition_request", "GrabLeft")
		elif Direction.x > 0:
			Animator.set("parameters/HangMovement/transition_request", "GrabRight")
	else:
		_StateMachine.ChangeState(self, "GrabIdle", null)
		
	if !CheckWallCollider.is_colliding() and !CheckAirWallCollider.is_colliding():
		_StateMachine.ChangeState(self, "Idle", null)
		
	
func Update(delta):
	pass
		
func Exit(Argument):
	Animator.set("parameters/list/transition_request", "BasicMovement")
	_Player.Gravity = _Player.StartGravity
