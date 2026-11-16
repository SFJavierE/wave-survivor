class_name attackdistance
extends Node2D

var enemy_to_shoot : CharacterBody2D = null

signal fire_projectile(char : CharacterBody2D)

func _process(delta: float) -> void:
	if enemy_to_shoot:
		fire_projectile.emit($".")

func reset_enemy(char : CharacterBody2D) -> void:
	var char_life = char.get_node_or_null("CharLife")
	if char_life:
		char_life.CharLifeZero.disconnect(reset_enemy)
	enemy_to_shoot = null

func _on_attack_area_enemy_entered(char: Node2D) -> void:
	if char is Enemy and not enemy_to_shoot:
		enemy_to_shoot = char
		var char_life = char.get_node_or_null("CharLife")
		if char_life:
			if char_life.CharLifeZero.is_connected(reset_enemy):
				return
			char_life.CharLifeZero.connect(reset_enemy)
