class_name HUD
extends Node

signal score_change
signal lives_change

@onready var lives_label: Label = $MarginContainer/LivesLabel
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel


func update_lives(lives) -> void:
	lives_label.text = "Lives: " + str(lives)


func update_score(score) -> void:
	score_label.text = "Score: " + str(score)


func game_over_display(boolean) -> void:
	game_over_label.visible = boolean
