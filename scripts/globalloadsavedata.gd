extends Node

class_name GlobalLoadSaveData

var save_data_path = "user://save_data.tres"  #user://save_data.tres
var save_data : SaveData

func _ready():
	save_data = load_save_data()
	print("happen")

func load_save_data() -> SaveData:
	if ResourceLoader.exists(save_data_path):
		return load(save_data_path)
	else:
		var new_save_data = SaveData.new()
		return new_save_data

func saving_save_data():
	ResourceSaver.save(save_data, save_data_path)
