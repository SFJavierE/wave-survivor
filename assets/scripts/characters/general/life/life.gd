class_name life_
extends Node

@onready var character : CharacterBody2D = $".."

@export var total_life : float = 10
var current_life : float = 0

signal is_dead(_char : CharacterBody2D)

func _ready() -> void:
	current_life = total_life

func reset_life() -> void:
	current_life = total_life

func get_damage(damage : float) -> void:
	current_life -= damage
	if current_life <= 0:
		is_dead.emit(character)

func restore_life(life_restored : float) -> void:
	if current_life < total_life:
		current_life += life_restored
		if current_life > total_life:
			current_life = total_life
