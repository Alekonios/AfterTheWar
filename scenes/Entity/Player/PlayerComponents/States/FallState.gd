extends State

@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D
@export var FallTimer : Timer
@export var FloorCollider : RayCast3D

@onready var Animator = %AnimationTree
var Debug = false

var time : int = 1

func Enter(Argument):
	FallTimer.start()
	Animator.set("parameters/OtherComponents/transition_request", "Fall")
	
func Update(delta):
	%DebugLabel.text = str(time)
	if FloorCollider.is_colliding() and !Debug:
		FallTimer.stop()
		Animator.set("parameters/OtherComponents/transition_request", "BaseMovement")
		if time < 2:
			Animator.set("parameters/LandingTrans/transition_request", "LightLanding")
		else:
			Animator.set("parameters/LandingTrans/transition_request", "HardLanding")
			
		Animator.set("parameters/Landing/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		_Player.velocity.x = 0.0
		_Player.velocity.z = 0.0
		Debug = true
	if CheckWallCollider.is_colliding() and !CheckAirWallCollider.is_colliding():
		_StateMachine.ChangeState(self, "GrabIdle", null)
		
func Exit(Argument):
	Debug = false
	time = 1
	FallTimer.stop()
	
#привязка к этой функции через ключ анимации, Дима соси
func land():
	_StateMachine.ChangeState(self, "Idle", null)
	

func _on_fall_timer_timeout() -> void:
	time += 1
	
