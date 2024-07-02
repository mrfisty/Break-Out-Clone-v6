class_name Player
extends CharacterBody2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _physics_process(delta : float) -> void:
	var mouse_position = get_global_mouse_position()
	velocity.x = mouse_position.x - global_position.x 
	move_and_collide(velocity)
