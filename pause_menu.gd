extends Control


## Checks for back input to exit
func _input(event):
	if event.is_action_pressed("back") and get_tree().paused:
		unpause()


## Unpause game, hide Pause Menu
func unpause():
	self.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false


## Returns to the game and hides the menu
func _on_resume_pressed():
	unpause()


## Returns to main menu
func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(Levels.levels[0])


## Quits tree
func _on_exit_pressed():
	get_tree().quit()
