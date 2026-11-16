class_name player_
extends CharacterBody2D

@onready var PLAYER: player_ = $"."
@export var speed : float = 200.0

var followers_manager : followersmanager

func _ready() -> void:
	followers_manager = followersmanager.new()

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")

	var direction = Vector2(direction_x, direction_y)
	if direction != Vector2.ZERO:
		velocity = direction * speed
		followers_manager.update_followers_positions(PLAYER)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_area_body_entered(body_: Node2D) -> void:
	if body_ is follower_:
		followers_manager.add_follower(body_)
