extends Node

enum WINDOW_STATE { WINDOWED, FULLSCREEN}
var default_state = WINDOW_STATE.FULLSCREEN
var window_state = WINDOW_STATE.FULLSCREEN

func _physics_process(delta: float) -> void:
	
	match window_state:
		WINDOW_STATE.WINDOWED:
			DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
			if Input.is_action_just_pressed("SwitchWindowMode"):
				window_state = WINDOW_STATE.FULLSCREEN

		WINDOW_STATE.FULLSCREEN:
			DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
			if Input.is_action_just_pressed("SwitchWindowMode"):
				window_state = WINDOW_STATE.WINDOWED
