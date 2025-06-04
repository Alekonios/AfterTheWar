extends State

@export var FloorJumpTimer : Timer
@onready var Animator = %AnimationTree

var WantJump = false

func Enter(Argument):
	if WantJump:
		_Player.velocity.y = _Player.JumpSpeed
		if Argument:
			_Player.velocity.x = 0
			_Player.velocity.z = 0
			_Player.velocity.x = lerp(_Player.velocity.x, clamp(Argument.x * 1.5, -3.0, 3.0)  , 3.0)
			_Player.velocity.z = lerp(_Player.velocity.z, clamp(-Argument.z * 1.5, -3.0, 3.0) , 3.0)
		Animator.set("parameters/Jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_StateMachine.ChangeState(self, "MoveState", null)
func Update(delta):
	pass
		
func Exit(Argument):
	pass
	

func _on_floor_jump_time_timeout() -> void:
	WantJump = false

func _process(delta: float) -> void:
	if _Player.is_on_floor() and !WantJump:
		WantJump = true
	elif WantJump and FloorJumpTimer.is_stopped():
		FloorJumpTimer.start()
