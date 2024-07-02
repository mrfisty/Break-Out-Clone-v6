class_name Ball
extends CharacterBody2D

signal ball_hit


@export var start_position := Vector2(320, 240)
@export var start_speed := 100.0
@export var max_speed := 320.0
@export var speed_increase_increment := 20.0

var current_speed := start_speed

@onready var hit_brick_sfx: AudioStreamPlayer = $HitBrickSFX
@onready var hit_paddle_sfx: AudioStreamPlayer = $HitPaddleSFX


func _ready() -> void:
	randomize()
	reset_ball()


func _physics_process(delta : float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		emit_signal("ball_hit", collider)
		velocity = (velocity.bounce(collision.get_normal())
		.normalized() * current_speed)
		increase_speed()
		if collider is Brick:
			hit_brick_sfx.play()
		if collider is Player:
			hit_paddle_sfx.play()


func reset_ball() -> void:
	velocity = Vector2.ZERO 
	position = start_position
	current_speed = start_speed
	random_direction()


func random_direction() -> void:
	var choice = 1 if randi() % 2 == 0 else 2
	if choice == 1:
		velocity = Vector2(start_speed, start_speed)
	else:
		velocity = Vector2(-start_speed, start_speed)


func increase_speed() -> void:
	if current_speed < max_speed:
		current_speed += speed_increase_increment
