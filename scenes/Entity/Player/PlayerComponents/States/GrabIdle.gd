extends State


@export var LeftHandIK : SkeletonIK3D
@export var RightHandIK : SkeletonIK3D
@export var LeftHandMarker : Marker3D
@export var RightHandMarker : Marker3D
@export var LeftWallHandMarker : Marker3D
@export var RightWallHandMarker : Marker3D
@export var CheckWallCollider : RayCast3D
@export var CheckWallEndPointCollider : RayCast3D

@onready var Animator = %AnimationTree

var Grabbing = false

func Enter(Argument):
	LeftHandIK.start()
	RightHandIK.start()
	
	Animator.set("parameters/list/transition_request", "HangMovement")
	
func Update(delta):
	var WallPoint = CheckWallCollider.get_collision_point()
	var WallEndPoint = CheckWallEndPointCollider.get_collision_point()
	var offset = Vector3(0, 1, 0)
	RightHandMarker.global_position = lerp(RightHandMarker.global_position, RightWallHandMarker.global_position, 0.2)
	LeftHandMarker.global_position = lerp(LeftHandMarker.global_position, LeftWallHandMarker.global_position, 0.2)
	_Player.velocity.y = 0
	_Player.Gravity = 0
	_Player.velocity.x = lerp(_Player.velocity.x, 0.0, 0.2)
	_Player.velocity.z = lerp(_Player.velocity.z, 0.0, 0.2)
	Animator.set("parameters/HangMovement/transition_request", "Hanging")
	CheckWallEndPointCollider.global_transform.origin = WallPoint + offset
	%MeshInstance3D.global_transform.origin = WallEndPoint
	LeftWallHandMarker.global_position.y = WallEndPoint.y
	RightWallHandMarker.global_position.y = WallEndPoint.y
	if Input.is_action_just_released("Jump"):
		Exit(null)
		_StateMachine.ChangeState(self, "Idle", null)
	
	
	
func Exit(Argument):
	LeftHandIK.stop()
	RightHandIK.stop()
	_Player.Gravity = _Player.StartGravity
	Animator.set("parameters/list/transition_request", "BasicMovement")
	
