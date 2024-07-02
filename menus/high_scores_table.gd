extends Node

@onready var first_place_label: Label = %FirstPlaceLabel
@onready var second_place_label: Label = %SecondPlaceLabel
@onready var third_place_label: Label = %ThirdPlaceLabel


func _ready() -> void:
	display_high_scores()


func display_high_scores() -> void:
	var scores = HighScores.save_data["scores"]
	scores.sort_custom(func(a, b): return a["score"] > b["score"])
	
	if scores.size() > 0:
		first_place_label.text = ("1st: " + str(scores[0]["score"]) + 
		" - " + scores[0]["date"])
	if scores.size() > 1:
		second_place_label.text = ("2nd: " + str(scores[1]["score"]) + 
		" - " + scores[1]["date"])
	if scores.size() > 2:
		third_place_label.text = ("3rd: " + str(scores[2]["score"]) + 
		" - " + scores[2]["date"])
	else:
		return


func _on_back_button_pressed() -> void:
	SceneManager.switch_scene("Menu")
