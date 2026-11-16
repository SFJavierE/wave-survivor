class_name follower_
extends CharacterBody2D

@export var speed : float = 120.0

var player_position : Vector2
const DISTANCE_TO_STOP : float = 50.0

func set_player_position(_position : Vector2) -> void:
	player_position = _position

func _physics_process(_delta: float) -> void:
	if not player_position:
		return
	var distance = global_position - player_position
	if distance.length() > DISTANCE_TO_STOP:
		var direction = global_position.direction_to(player_position)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
