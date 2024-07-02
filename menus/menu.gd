class_name StartScreenBind
extends Node

@onready var play: Button = %PlayButton
@onready var scores: Button = %ScoresButton
@onready var options: Button = %OptionsButton
@onready var credits: Button = %CreditsButton
@onready var quit: Button = %QuitButton


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	play.pressed.connect(handle_menu_press.bind(play))
	scores.pressed.connect(handle_menu_press.bind(scores))
	options.pressed.connect(handle_menu_press.bind(options))
	credits.pressed.connect(handle_menu_press.bind(credits))
	quit.pressed.connect(handle_menu_press.bind(quit))


func handle_menu_press(button_pressed) -> void:
	match button_pressed:
		play:
			play_game()
		scores:
			open_scores()
		options:
			open_options()
		credits:
			open_credits()
		quit:
			SceneManager.quit_game()


func play_game() -> void:
	SceneManager.switch_scene("Level")


func open_scores() -> void:
	SceneManager.switch_scene("Scores")


func open_options() -> void:
	SceneManager.switch_scene("Options")


func open_credits() -> void:
	SceneManager.switch_scene("Credits")
