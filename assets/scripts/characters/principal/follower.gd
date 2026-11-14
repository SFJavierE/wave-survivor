class_name PlayerFollower
extends CharacterBody2D

@export var SPEED : float = 120.0

var leader_position : Vector2
const DISTANCE_TO_STOP : float = 50.0

var enemy_to_shoot : CharacterBody2D = null

signal fire_projectile(char : CharacterBody2D)

func SetFollowing(l : Vector2) -> void:
	leader_position = l

func _process(delta: float) -> void:
	if enemy_to_shoot:
		look_at(enemy_to_shoot.global_position)
		fire_projectile.emit($".")

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

func ResetFollow(char : CharacterBody2D) -> void:
	var char_life = char.get_node_or_null("CharLife")
	if char_life:
		char_life.CharLifeZero.disconnect(ResetFollow)
	enemy_to_shoot = null

func _on_area_enemy_entered(char: CharacterBody2D) -> void:
	if char is Enemy and not enemy_to_shoot:
		enemy_to_shoot = char
		var char_life = char.get_node_or_null("CharLife")
		if char_life:
			if char_life.CharLifeZero.is_connected(ResetFollow):
				return
			char_life.CharLifeZero.connect(ResetFollow)
