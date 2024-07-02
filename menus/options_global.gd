extends Node

const SAVE_FILE_PATH = "user://options.dat"
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var options = {
	"master_volume": 1.0,
	"music_volume": 1.0,
	"sfx_volume": 1.0,
}


func _ready() -> void:
	load_options()
	apply_options()


func save_options() -> void:
	print("Saving options: ", options)
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(options)
	file.close()


func load_options() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		options = file.get_var()
		file.close()
		print("Loaded options: ", options)
	else:
		print("No saved options found")


func apply_options():
	set_master_volume(options.master_volume)
	set_music_volume(options.music_volume)
	set_sfx_volume(options.sfx_volume)


func set_master_volume(value: float) -> void:
	options.master_volume = value
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.02)


func set_music_volume(value: float) -> void:
	options.music_volume = value
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.02)


func set_sfx_volume(value: float) -> void:
	options.sfx_volume = value
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.02)
