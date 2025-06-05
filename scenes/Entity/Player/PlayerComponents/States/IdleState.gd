extends State


@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D
@export var FloorCheckCollider : RayCast3D

@onready var Animator = %AnimationTree

func Enter(Argument):
	%NormalCollision.disabled = false
	%CrouchCollision.disabled = true
	
func Update(delta):
	_Player.velocity.x = lerp(_Player.velocity.x, 0.0, 0.2)
	_Player.velocity.z = lerp(_Player.velocity.z, 0.0, 0.2)
	Animator.set("parameters/BasicMovement/transition_request", "Idle")
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	if InputDir.normalized():
		_StateMachine.ChangeState(self, "MoveState", null)
	if Input.is_action_just_pressed("Jump"):
		_StateMachine.ChangeState(self, "Jump", null)
	if !FloorCheckCollider.is_colliding() and !_Player.is_on_floor():
		_StateMachine.ChangeState(self, "Fall", null)
	if Input.is_action_pressed("Crouch"):
		_StateMachine.ChangeState(self, "CrouchIdle", null)

		
func Exit(Argument):
	pass

	
