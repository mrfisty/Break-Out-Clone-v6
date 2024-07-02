extends Node

@onready var master_slider = $MarginContainer/OptionsContainer/VBoxContainer/GridContainer/MasterSlider
@onready var music_slider = $MarginContainer/OptionsContainer/VBoxContainer/GridContainer/MusicSlider
@onready var sfx_slider = $MarginContainer/OptionsContainer/VBoxContainer/GridContainer/SFXSlider


func _ready():
	master_slider.value = OptionsGlobal.options.master_volume
	music_slider.value = OptionsGlobal.options.music_volume
	sfx_slider.value = OptionsGlobal.options.sfx_volume


func _on_master_slider_value_changed(value: float) -> void:
	OptionsGlobal.set_master_volume(value)

func _on_music_slider_value_changed(value: float) -> void:
	OptionsGlobal.set_music_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	OptionsGlobal.set_sfx_volume(value)


func _on_back_button_pressed() -> void:
	OptionsGlobal.save_options()
	SceneManager.switch_scene("Menu")
