extends Node

const SAVE_FILE_PATH = "user://scores.dat"

var save_data: Dictionary  = {"scores" : []}


func _ready() -> void:
	load_save_file()


func load_save_file() -> void:
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()


func save() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


func add_score(score : int) -> void:
	var date_dict = Time.get_date_dict_from_system()
	var formatted_date = (str(date_dict["month"])
	+ "/" + str(date_dict["day"])
	+ "/" + str(date_dict["year"]))
	
	var score_entry = {
		"score": score,
		"date": formatted_date
	}
	save_data["scores"].append(score_entry)
	save()
