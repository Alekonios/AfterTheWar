extends State

@onready var Animator = %AnimationTree
@export var FloorCollider : RayCast3D

func Enter(Argument):
	Animator.set("parameters/OtherComponents/transition_request", "Fall")
	
func Update(delta):
	if FloorCollider.is_colliding():
		Animator.set("parameters/OtherComponents/transition_request", "BaseMovement")
		Animator.set("parameters/Landing/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		await Animator.animation_finished
		_StateMachine.ChangeState(self, "Idle", null)
		
	
func Exit(Argument):
	pass
