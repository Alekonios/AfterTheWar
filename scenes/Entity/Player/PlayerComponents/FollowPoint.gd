class_name CameraManager

extends Node

@export var _Components : Components
@export var player: CharacterBody3D
@export var camera: Camera3D
@export var camera_follow: Node3D
@export var Reset_To_Idle_Timer: Timer

enum STATE { STATIC, FOLLOWING, IDLE}
var state = STATE.STATIC

@export var move_away = 0.3
var follow_treshold: float = 2.0
var smoothing_speed: float = 0.05
var smoothing_speed_alt: float = 0.008
var delta: float = Engine.get_frames_per_second()

var StoreRotation: bool = false

func _physics_process(delta: float) -> void:
	keep_distance_to_player()
	camera_look_at()
	#print(Reset_To_Idle_Timer.time_left)


func keep_distance_to_player():
	var distance_to_player = camera_follow.position.distance_to(player.position)
	var direction = Input.get_axis("MoveLeft", "MoveRight")


	match state:
		STATE.STATIC:
			#print("static")
			camera_follow.position = lerp(camera_follow.position, player.position, smoothing_speed_alt * delta)
			if distance_to_player >= follow_treshold:
				state = STATE.FOLLOWING

		STATE.FOLLOWING:
			#print("follow")
			camera_follow.position = lerp(camera_follow.position, player.position + Vector3(0, 1, move_away * direction), 0.02 * delta)
			if distance_to_player <= 1.1 and _Components._StateMachine.CurrentState.name.to_lower() != "movestate":
				state = STATE.STATIC

		#STATE.IDLE:
			#print("idle")
			#camera_follow.position = lerp(camera_follow.position, player.position, smoothing_speed * delta)
			#if Reset_To_Idle_Timer.wait_time == 0 and player.is_walking:
				#state = STATE.FOLLOWING

func camera_look_at():
	#var InputDir = Input.get_vector("MoveUp", "MoveDown", "MoveLeft", "MoveRight")
	#var Direction = (player.transform.basis * Vector3(InputDir.x, 0.0, InputDir.y)).normalized()
	#var MaxPositiveRotation = Vector3( 0, deg_to_rad(80) ,0) 
	#var MaxNegativeRotation = Vector3( 0, deg_to_rad(100) ,0)
#
	#var StoredDirection: String
	#var StoredDirectionBuffer: String

	#for key in player.MovementKeys:
		#if Input.is_action_just_pressed(key):
			#if key != StoredDirection:
				#StoredDirectionBuffer = StoredDirection  # Save the previous direction
				#StoredDirection = key  # Update to the new direction
			#print(StoredDirection, "1") 
			#print(StoredDirectionBuffer, "2")  


	camera.look_at(player.position)
	camera.rotation.y = clamp(camera.rotation.y, deg_to_rad(80) , deg_to_rad(100))
	camera.global_position.z = lerp(camera.global_position.z, camera_follow.global_position.z, 0.008 * delta)
	#print(camera.rotation.y)

	#if camera.rotation.y >= MaxPositiveRotation.y or camera.rotation.y >= MaxNegativeRotation.y:
		##camera.rotation.y = deg_to_rad(90)
		#StoreRotation = true
		##print(StoreRotation)
#
	#if StoredDirection != StoredDirectionBuffer:
		#StoreRotation = false 
