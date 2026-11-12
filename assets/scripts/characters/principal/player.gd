class_name PlayerC
extends CharacterBody2D

@onready var player: PlayerC = $"."
@onready var area: Area2D = $Area2D
@export var SPEED : float = 200.0

var FollowerM : FollowerManager

func _ready() -> void:
	FollowerM = FollowerManager.new()

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")

	var direction = Vector2(direction_x, direction_y)
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		FollowerM.UpdateFollowerPosition(player)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_area_body_entered(char: Node2D) -> void:
	if char is PlayerFollower:
		FollowerM.AddFollower(char)
