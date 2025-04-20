extends State

@onready var Animator = %AnimationTree

@export var Model : Node3D
@export var DebugMoveVis : Node3D

func Enter():
	pass
	
func Update(delta):
	pass
	
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
		Animator.set("parameters/BasicMovement/transition_request", "Walk")
	else:
		_StateMachine.ChangeState(self, "Idle")
	
func Exit():
	pass
