
class_name FixedCameraComponent
extends Node


@export var PlayerCamera: Camera3D
@export var FixedCamera: Camera3D
@export var CameraArea: Area3D

var IsInArea: bool = false
var player: CharacterBody3D


func _physics_process(delta: float) -> void:
	if IsInArea == true:
		PlayerCamera.global_position = lerp(PlayerCamera.global_position, FixedCamera.global_possition, 0.5 * delta)

func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	IsInArea = true
	player = body

func _on_area_3d_body_exited(body: CharacterBody3D) -> void:
	IsInArea = false
	player = null
