class_name CharLife
extends Node

@export var CHAR : CharacterBody2D = null
@export var total_life : float = 10

var current_life : float = 0

signal CharLifeZero(char : CharacterBody2D)

func _ready() -> void:
	current_life = total_life

func ResetLife() -> void:
	current_life = total_life

func GetDamage(damage : float) -> void:
	current_life -= damage
	if current_life <= 0:
		CharLifeZero.emit(CHAR)

func RestoreLife(restore : float) -> void:
	if current_life < total_life:
		current_life += restore
		if current_life > total_life:
			current_life = total_life
