extends State

@onready var Animator = %AnimationTree

@export var FloorCheckCollider : RayCast3D
@export var Model : Node3D
@export var DebugMoveVis : Node3D

var AnimName = "Walk"

func Enter(Argument):
	pass
	
func Update(delta):
	if !FloorCheckCollider.is_colliding() and !_Player.is_on_floor():
		_StateMachine.ChangeState(self, "Fall", null)
	
func _physics_process(delta: float) -> void:
	if _StateMachine.CurrentState.name.to_lower() != StateName.to_lower():
		return
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	var Direction = (_Player.transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	if Direction:
		_Player.velocity.x = lerp(_Player.velocity.x, Direction.x * _Player.Speed, 0.2)
		_Player.velocity.z = lerp(_Player.velocity.z, -Direction.z * _Player.Speed, 0.2)
		DebugMoveVis.look_at(Direction + _Player.position)
		Model.rotation.y = lerp_angle(Model.rotation.y, -DebugMoveVis.rotation.y, 0.2)
		Animator.set("parameters/BasicMovement/transition_request", AnimName)
	else:
		_StateMachine.ChangeState(self, "Idle", null)
	if Input.is_action_pressed("Run"):
		_Player.Speed = lerp(_Player.Speed, _Player.RunSpeed, 0.2)
		AnimName = "Run"
	else:
		_Player.Speed = lerp(_Player.Speed, _Player.StartSpeed, 0.2)
		AnimName = "Walk"
	if Input.is_action_just_pressed("Jump"):
		match AnimName:
			"Walk":
				_StateMachine.ChangeState(self, "Jump", Direction * 0.3)
			"Run":
				_StateMachine.ChangeState(self, "Jump", Direction )
	
func Exit(Argument):
	pass
