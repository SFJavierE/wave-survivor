class_name attackdistance
extends Node2D

@onready var fire_rate: Timer = $fire_rate
@export var rate_fire : float = .6

var enemy_to_shoot : CharacterBody2D = null

var can_shoot : bool = true

signal fire_projectile(shoot_point : Node2D)

func _process(_delta: float) -> void:
	if enemy_to_shoot and can_shoot:
		can_shoot = false
		fire_rate.start(rate_fire)
		look_at(enemy_to_shoot.global_position)
		fire_projectile.emit($".")

func reset_enemy(_char : CharacterBody2D) -> void:
	var char_life = _char.get_node_or_null("Life")
	if char_life:
		char_life.is_dead.disconnect(reset_enemy)
	enemy_to_shoot = null

func _on_attack_area_enemy_entered(_char: Node2D) -> void:
	if _char is Enemy and not enemy_to_shoot:
		enemy_to_shoot = _char
		var char_life = _char.get_node_or_null("Life")
		if char_life:
			if char_life.is_dead.is_connected(reset_enemy):
				return
			char_life.is_dead.connect(reset_enemy)


func _on_fire_rate_timeout() -> void:
	can_shoot = true
	fire_rate.stop()
