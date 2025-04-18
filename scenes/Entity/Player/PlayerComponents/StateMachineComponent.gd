class_name StateMachineComponent

extends Node

@export_category("Nodes")
@export var _Components : Components
@export var _AnimationTree : AnimationTree

@export_category("Parameters")
enum States {BasicMovement, CrouchMovement, HangMovement}
enum BasicMovementStates {Idle, Walk, Run}
enum CrouchMovementStates {Idle, CrouchWalk, QuietWalk}
enum HangMovement {Idle, GrabLeft, GrabRight}

@export var State : States
