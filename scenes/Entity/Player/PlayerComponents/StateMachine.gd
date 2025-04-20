class_name StateMachine

extends Node

@export_category("States")
@export var InitState : State
@export var CurrentState : State

@export_category("Nodes")
@export var Player : CharacterBody3D
@onready var Animator = %AnimationTree

var States : Dictionary = {}

func _ready() -> void:
	for Child in get_children():
		if Child is State:
			States[Child.name.to_lower()] = Child
		
	if !InitState:
		return
	CurrentState = InitState
	
func _process(delta: float) -> void:
	if !CurrentState:
		return
	CurrentState.Update(delta)
	
func ChangeState(SourseState : State, NewState : String):
	if SourseState.name.to_lower() == NewState.to_lower():
		return
	CurrentState = States.get(NewState.to_lower())
	CurrentState.Enter()
		
	
	
	
			
