class_name PlayerFollower
extends CharacterBody2D

@export var SPEED : float = 120.0

var leader_position : Vector2
const DISTANCE_TO_STOP : float = 50.0

func SetFollowing(l : Vector2) -> void:
	leader_position = l

func _physics_process(_delta: float) -> void:
	if not leader_position:
		return
	var distance = global_position - leader_position
	if distance.length() > DISTANCE_TO_STOP:
		var direction = global_position.direction_to(leader_position)
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
