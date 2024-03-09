extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().hide()
	$VBoxContainer/ResumeButton.connect("pressed", Callable(self, "resume"))
	$VBoxContainer/RestartButton.connect("pressed", Callable(self, "restart"))
	$VBoxContainer/MainMenuButton.connect("pressed", Callable(self, "back_to_mainmenu"))
	$VBoxContainer/QuitButton.connect("pressed", Callable(self, "quit"))
	
	set_score_text()

func resume():
	unpause()

func restart():
	unpause()
	get_tree().reload_current_scene()

func set_game_over():
	$Title.set_text("GAME OVER")
	$VBoxContainer/ResumeButton.hide()
	set_process_unhandled_input(false)
	pause()

func set_score_text():
	$HighScore.set_text("HIGH SCORE : " + str(Globalloadsavedata.save_data.high_score))
	$LastScore.set_text("LAST SCORE : " + str(Globalloadsavedata.save_data.last_score))

func back_to_mainmenu():
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func quit():
	get_tree().quit()

func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("pause"):
			if get_tree().is_paused():
				unpause()
			else:
				pause()
				

func pause():
	get_tree().set_pause(true)
	get_parent().show()

func unpause():
	get_tree().set_pause(false)
	get_parent().hide()
