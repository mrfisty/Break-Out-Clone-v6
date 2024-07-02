class_name Level
extends Node

enum GameState {
	PLAYING,
	GAMEOVER,
}

var game_state : GameState
var player_score := 0 
var player_lives := 3

@onready var ball: Ball = $Ball
@onready var hud: HUD = $HUD
@onready var music_player: AudioStreamPlayer = $Audio/MusicPlayer
@onready var ball_died_sfx: AudioStreamPlayer = $Audio/BallDiedSFX
@onready var game_over_sfx: AudioStreamPlayer = $Audio/GameOverSFX


func _ready() -> void:
	game_state = GameState.PLAYING
	update_hud()
	
	ball.connect("ball_hit", _on_ball_hit)
	hud.connect("lives_change", _on_lives_change)
	hud.connect("score_change", _on_score_change)


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept") and game_state == GameState.GAMEOVER:
		restart_game()


func game_over() -> void:
	game_state = GameState.GAMEOVER
	HighScores.add_score(player_score)
	hud.game_over_display(true)
	game_over_sfx.play()


func restart_game() -> void:
	SceneManager.restart_scene()


func update_hud() -> void:
	_on_lives_change(player_lives)
	_on_score_change(player_score)


func _on_ball_hit(collider) -> void:
	if collider is Brick:
		var row = collider.get_parent()
		player_score += row.row_points
		_on_score_change(player_score)
		collider.queue_free()


func _on_dead_zone_body_entered(body: Node2D) -> void:
	_on_ball_died()
	ball_died_sfx.play()


func _on_ball_died() -> void:
	if game_state == GameState.PLAYING:
		player_lives -= 1
	_on_lives_change(player_lives)
	if player_lives > 0:
		ball.reset_ball()
	else:
		game_over()


func _on_lives_change(lives : int) -> void:
	hud.update_lives(player_lives)


func _on_score_change(score : int) -> void:
	hud.update_score(player_score)
