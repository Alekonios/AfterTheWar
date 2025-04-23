extends State

@export var CeilingCollider : ShapeCast3D

@onready var Animator = %AnimationTree


func Enter(Argument):
	%NormalCollision.disabled = true
	%CrouchCollision.disabled = false
	
func Update(delta):
	_Player.velocity.x = lerp(_Player.velocity.x, 0.0, 0.2)
	_Player.velocity.z = lerp(_Player.velocity.z, 0.0, 0.2)
	Animator.set("parameters/list/transition_request", "CrouchMovement")
	Animator.set("parameters/Crouch/transition_request", "CrouchIdle")
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	if InputDir.normalized():
		_StateMachine.ChangeState(self, "CrouchMove", null)
	if !Input.is_action_pressed("Crouch") and !CeilingCollider.is_colliding():
		Animator.set("parameters/list/transition_request", "BasicMovement")
		_StateMachine.ChangeState(self, "Idle", null)
func Exit(Argument):
	pass
	
