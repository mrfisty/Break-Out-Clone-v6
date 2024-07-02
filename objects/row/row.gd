class_name Row
extends Node2D

enum RowColor {
	RED,
	ORANGE,
	GREEN,
	YELLOW
}

@export var row_size : int
@export var row_color : RowColor
@export var row_points : int
@export var brick_tscn : PackedScene


var color_mapping := {
	RowColor.RED: Color(1, 0, 0),
	RowColor.ORANGE: Color(1, 0.5, 0),
	RowColor.GREEN: Color(0, 1, 0),
	RowColor.YELLOW: Color(1, 1, 0),
}

func _ready() -> void:
	place_bricks()
	apply_color()


func place_bricks() -> void:
	var first_brick = brick_tscn.instantiate()
	add_child(first_brick)
	var prev_brick = get_child(0)
	var brick_width = (prev_brick.get_node("Sprite2D")
		.texture.get_size().x)
	
	for i in range(row_size - 1): 
		var brick = brick_tscn.instantiate()
		add_child(brick)
		brick.position = Vector2(
			prev_brick.position.x + brick_width,
			prev_brick.position.y
			)
		prev_brick = brick


func apply_color() -> void:
	var color = color_mapping.get(row_color)
	for brick in get_children():
		brick.get_node("Sprite2D").modulate = color
