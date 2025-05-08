
class_name FixedCameraComponent
extends Node

@export var PlayerCamera: Camera3D
@export var FixedCamera: Camera3D
@export var CameraArea: Area3D
@export var player: CharacterBody3D

var IsInArea: bool = false


func _ready() -> void:
	CameraArea.body_entered.connect(_on_body_entered)
	CameraArea.body_exited.connect(_on_body_exited)


func _physics_process(delta: float) -> void:
	if IsInArea == true:
		PlayerCamera.global_position = lerp(PlayerCamera.global_position, FixedCamera.global_position, 2 * delta)


func _on_body_entered(body: Node) -> void:
	if body is CharacterBody3D:
		IsInArea = true
		player = body
		print("Player In Area")
		print(body)

func _on_body_exited(body: Node) -> void:
	if body is CharacterBody3D:
		IsInArea = false
		player = null
		print("Player Not In Area")
