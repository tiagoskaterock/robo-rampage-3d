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
	$YeahAudio.play()	
	$TimerToRestart.start()


func _on_quit_button_pressed():
	$NoAudio.play()
	

func _on_timer_to_restart_timeout():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_timer_to_quit_timeout():
	get_tree().quit()


func _on_no_audio_finished():
	$TimerToQuit.start()
