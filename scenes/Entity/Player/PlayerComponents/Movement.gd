
class_name Movement
extends CharacterBody3D

@export_category("Stats")
@export var StartSpeed : float = 5.0
@export var StartJump : float = 2.0
@export var StartGravity = 2
var Speed
var JumpVel
var Gravity


@export_category("Nodes")
@export var Model : Node3D
@export var DebugMoveVis : Node3D
@export var FloorJumpTimer : Timer

var WantJump = true
var is_walking: bool = false
	
func _ready() -> void:
	Speed = StartGravity
	JumpVel = StartJump
	Gravity = StartGravity


func _physics_process(delta: float) -> void:
	

	var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	var Direction = (transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	if Direction:
		velocity.x = lerp(velocity.x, Direction.x * Speed, 0.2)
		velocity.z = lerp(velocity.z, -Direction.z * Speed, 0.2)
		DebugMoveVis.look_at(Direction + position)
		Model.rotation.y = lerp_angle(Model.rotation.y, -DebugMoveVis.rotation.y, 0.2)
		is_walking = true
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		velocity.z = lerp(velocity.z, 0.0, 0.2)
		is_walking = false
		
		
	if Input.is_action_just_pressed("Jump") and WantJump or !FloorJumpTimer.is_stopped():
		velocity.y = JumpVel
		if FloorJumpTimer.is_stopped():
			FloorJumpTimer.start()
		
	if is_on_floor():
		WantJump = true
		
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
