extends Control


func _ready():
	visible = false
	
	
func game_over():
	get_tree().paused = true
	$GameOverScream.play()
	visible = true
	print('game over menu')	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE	


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()
