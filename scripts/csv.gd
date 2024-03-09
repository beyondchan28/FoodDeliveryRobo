extends Control

var data_array: Array

func _ready():
	read_csv()
	create_dropdown_item()
	$OptionButton.connect("item_selected", Callable(self, "selected_job"))
	$Button.connect("pressed", Callable(self, "back_to_mainmenu"))

func back_to_mainmenu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func create_dropdown_item():
	for arr_ind in data_array.size():
		$OptionButton.add_item(data_array[arr_ind][0])


func read_csv():
	var file = FileAccess.open("res://resource/class.csv", FileAccess.READ)
	while !file.eof_reached():
		var csv: Array = file.get_csv_line()
		data_array.append(csv)
	file.close()
	#print(data_array)

func selected_job(index: int):
	$JobName.set_text(data_array[index][1])
	$Description.set_text(data_array[index][2])
	var arr_size : int = data_array[index].size()
	for child in $SkillBox.get_children():
		arr_size -= 1
		child.set_text(data_array[index][arr_size])
	
