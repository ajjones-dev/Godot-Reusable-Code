extends Node3D
class_name GameManager

signal toggle_game_paused(is_paused : bool)
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)
		get_node("/root/Main/Level/CanvasLayer").visible = !game_paused
		if game_paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif !game_paused:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event : InputEvent):
	if event.is_action_pressed("Pause"):
		game_paused = !game_paused
