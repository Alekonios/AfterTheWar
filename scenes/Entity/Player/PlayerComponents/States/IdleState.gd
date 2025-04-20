extends State

@onready var Animator = %AnimationTree

func Enter():
	pass
	
func Update(delta):
	_Player.velocity.x = lerp(_Player.velocity.x, 0.0, 0.2)
	_Player.velocity.z = lerp(_Player.velocity.z, 0.0, 0.2)
	Animator.set("parameters/BasicMovement/transition_request", "Idle")
	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	if InputDir.normalized():
		_StateMachine.ChangeState(self, "MoveState")
	
