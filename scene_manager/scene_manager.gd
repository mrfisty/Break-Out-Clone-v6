extends Node

@export var scenes : Dictionary = {}

var current_scene_alias : String = ""


func _ready() -> void:
	var main_scene : StringName = ProjectSettings.get_setting("application/run/main_scene")
	current_scene_alias = scenes.find_key(main_scene)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		OptionsGlobal.save_options()
		switch_scene("Menu") 


func add_scene(scene_alias : String, scene_path : String) -> void:
	scenes[scene_alias] = scene_path


func remove_scene(scene_alias : String) -> void:
	scenes.erase(scene_alias)


func switch_scene(scene_alias : String) -> void:
	get_tree().change_scene_to_file(scenes[scene_alias])


func restart_scene() -> void:
	get_tree().reload_current_scene()


func quit_game() -> void:
	get_tree().quit()


func get_scene_count() -> int:
	return scenes.size()


func get_current_scene_alias() -> String:
	return current_scene_alias
