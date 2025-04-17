
class_name FollowPoint
extends Node

@export var player: CharacterBody3D
@export var camera: Camera3D
@export var camera_follow: Node3D
@export var Reset_To_Idle_Timer: Timer

enum STATE { STATIC, FOLLOWING, IDLE}
var state = STATE.STATIC

@export var move_away = 1
var follow_treshold: float = 2.0
var smoothing_speed: float = 0.05
var smoothing_speed_alt: float = 0.008
var delta: float = Engine.get_frames_per_second()


func _physics_process(delta: float) -> void:
	keep_distance_to_player()
	camera_look_at()
	print(Reset_To_Idle_Timer.time_left)
	#camera.global_position.z = camera_follow.global_position.z


func keep_distance_to_player():
	var distance_to_player = camera_follow.position.distance_to(player.position)
	var direction = Input.get_axis("MoveLeft", "MoveRight")

	camera.look_at(camera_follow.position)

	match state:
		STATE.STATIC:
			print("static")
			camera_follow.position = lerp(camera_follow.position, player.position, smoothing_speed_alt * delta)
			if distance_to_player >= follow_treshold:
				state = STATE.FOLLOWING

		STATE.FOLLOWING:
			print("follow")
			camera_follow.position = lerp(camera_follow.position, player.position + Vector3(0, 1, move_away * direction), smoothing_speed * delta)
			if distance_to_player <= 1.1 and player.is_walking == false:
				state = STATE.STATIC

		#STATE.IDLE:
			#print("idle")
			#camera_follow.position = lerp(camera_follow.position, player.position, smoothing_speed * delta)
			##if Reset_To_Idle_Timer.wait_time == 0 and player.is_walking:
				##state = STATE.FOLLOWING

func camera_look_at():
	camera.look_at(camera_follow.position)
	camera.rotation.y = clamp(camera.rotation.y, deg_to_rad(60) , deg_to_rad(120))
	camera.global_position.z = lerp(camera.global_position.z, camera_follow.global_position.z, 0.1 * delta)
