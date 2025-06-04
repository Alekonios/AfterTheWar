extends State

@export var CeilingCollider : ShapeCast3D
@export var FloorCheckCollider : RayCast3D
@export var Model : Node3D
@export var DebugMoveVis : Node3D

@onready var Animator = %AnimationTree


func Enter(Argument):
	%NormalCollision.disabled = true
	%CrouchCollision.disabled = false
	
func Update(delta):
	if !FloorCheckCollider.is_colliding() and !_Player.is_on_floor():
		_StateMachine.ChangeState(self, "Fall", null)
	
func _physics_process(delta: float) -> void:
	if _StateMachine.CurrentState.name.to_lower() != StateName.to_lower():
		return
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	var Direction = (_Player.transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	if Direction:
		_Player.Speed = lerp(_Player.StartSpeed, _Player.CrouchRatio, 0.2)
		_Player.velocity.x = lerp(_Player.velocity.x, Direction.x * _Player.Speed, 0.2)
		_Player.velocity.z = lerp(_Player.velocity.z, -Direction.z * _Player.Speed, 0.2)
		DebugMoveVis.look_at(Direction + _Player.position)
		Model.rotation.y = lerp_angle(Model.rotation.y, -DebugMoveVis.rotation.y, 0.2)
		Animator.set("parameters/Crouch/transition_request", "CrouchWalk")
	else:
		_StateMachine.ChangeState(self, "CrouchIdle", null)
	if !InputDir:
		Animator.set("parameters/Crouch/transition_request", "CrouchIdle")
	if !Input.is_action_pressed("Crouch") and !CeilingCollider.is_colliding():
		_Player.Gravity = _Player.StartGravity
		_StateMachine.ChangeState(self, "Idle", null)
		
func Exit(Argument):
	Animator.set("parameters/list/transition_request", "BasicMovement")
