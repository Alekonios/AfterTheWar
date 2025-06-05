extends State

@export var CheckWallCollider : RayCast3D
@export var CheckAirWallCollider : RayCast3D
@export var WallMarker : Marker3D
@export var FallTimer : Timer
@export var FloorCollider : RayCast3D

@onready var Animator = %AnimationTree
var Debug = false

var time : int = 1

func Enter(Argument):
	FallTimer.start()
	Animator.set("parameters/OtherComponents/transition_request", "Fall")
	
func Update(delta):
	LedgeDetect()
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
		
func Exit(Argument):
	Debug = false
	time = 1
	Animator.set("parameters/OtherComponents/transition_request", "BaseMovement")
	FallTimer.stop()
	
	
func LedgeDetect():
	var WallPoint = CheckWallCollider.get_collision_point()
	var WallEndPoint = CheckAirWallCollider.get_collision_point()
	var offset = Vector3(0, 1, 0)
	if CheckWallCollider.is_colliding():
		CheckAirWallCollider.global_transform.origin = WallPoint + offset
		%MeshInstance3D.global_transform.origin = WallEndPoint
		if CheckAirWallCollider.global_position.distance_to(WallEndPoint) < 0.1:
			_StateMachine.ChangeState(self, "GrabIdle", true)
			
	
#привязка к этой функции через ключ анимации, Дима соси
func land():
	_StateMachine.ChangeState(self, "Idle", null)
	

func _on_fall_timer_timeout() -> void:
	time += 1
	
