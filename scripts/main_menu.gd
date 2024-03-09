extends Control

func _ready():
	$ButtonContainer/PlayButton.connect("pressed", Callable(self, "play"))
	$ButtonContainer/CSVButton.connect("pressed", Callable(self, "csv"))
	$ButtonContainer/QuitButton.connect("pressed", Callable(self, "quit"))
	$HintBackground/Label.set_text("HIGH SCORE : " + str(Globalloadsavedata.save_data.high_score))

func play():
	get_tree().change_scene_to_file("res://scenes/delivery_guy.tscn")

func csv():
	get_tree().change_scene_to_file("res://scenes/csv.tscn")

func quit():
	get_tree().quit()
