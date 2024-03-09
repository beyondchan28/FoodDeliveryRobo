extends Node2D

signal scoring(amount)
signal game_finish

@onready var box_indexes: Array
@onready var pause_menu = $UI/Background/PauseMenu

var score := 0
var package_delivered := 0

func _ready():
	$UI/Timer.connect("timeout", Callable(self, "time_out"))
	$UI/PauseButton.connect("pressed", Callable(pause_menu, "pause"))
	connect("scoring", Callable(self, "add_score"))
	connect("game_finish", Callable(self, "game_end"))
	var value := 0
	var packages: Array = $Packages.get_children()
	for child in packages:
		child.box_index = value
		box_indexes.append(value)
		value += 1
		
	for child in $PlaceToDeliver.get_children():
		var box_index = box_indexes.pick_random()
		box_indexes.erase(box_index)
		child.box_index_recipient_want = box_index
		child.get_node("Label").set_text(str(box_index))
		for box in packages:
			if box.box_index == box_index:
				child.get_node("Hint").set_texture(box.get_texture())
				break

func add_score(amount: int):
	score += amount
	package_delivered += 1
	$UI/Score.set_text("SCORE : " + str(score))
	
	if package_delivered == 4:
		emit_signal("game_finish")

func game_end():
	storing_data()
	pause_menu.set_score_text()
	pause_menu.set_game_over()

func time_out():
	storing_data()
	pause_menu.set_score_text()
	pause_menu.set_game_over()

func storing_data():
	var save_data = Globalloadsavedata.save_data
	save_data.last_score = score
	if score > save_data.high_score:
		save_data.high_score = score
	Globalloadsavedata.saving_save_data()
	

func _process(delta):
	$UI/TimerLabel.set_text("0:" + str($UI/Timer.get_time_left()).pad_decimals(0))
