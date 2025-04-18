class_name StateMachineComponent

extends Node

@export_category("Nodes")
@export var _Components : Components
@onready var Animator = %AnimationTree

@export_category("Parameters")
enum States {BasicMovement, CrouchMovement, HangMovement}
enum BasicMovementStates {Idle, Walk, Run}
enum CrouchMovementStates {Idle, CrouchWalk, QuietWalk}
enum HangMovement {Idle, GrabLeft, GrabRight}

@export var State : States = States.BasicMovement
@export var Condition = BasicMovementStates.Idle

func _process(delta: float) -> void:
	match State:
		States.BasicMovement:
			Animator.set("parameters/list/transition_request", "BasicMovement")
			match Condition:
				BasicMovementStates.Idle:
					Animator.set("parameters/BasicMovement/transition_request", "Idle")
				BasicMovementStates.Walk:
					Animator.set("parameters/BasicMovement/transition_request", "Walk")
				BasicMovementStates.Run:
					Animator.set("parameters/BasicMovement/transition_request", "Run")
					
func Jump():
	Animator.set("parameters/Jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
