class_name PoolChar
extends Node2D

@onready var pool: PoolChar = $"."
var enables : Array[CharacterBody2D] = []
var disables : Array[CharacterBody2D] = []

func AddCharToPool(char : CharacterBody2D) -> void:
	if enables.has(char):
		return
	enables.append(char)

	var char_life = char.get_node_or_null("CharLife")
	if char_life:
		if char_life.CharLifeZero.is_connected(CharDead):
			return
		char_life.CharLifeZero.connect(CharDead)

func CharDead(char : CharacterBody2D) -> void:
	enables.erase(char)
	if disables.has(char):
		return
	
	disables.append(char)
	char.visible = false
	char.process_mode = Node.PROCESS_MODE_DISABLED

func DisableCharHasElements() -> bool:
	return !disables.is_empty()
	
func ReturnChar() -> CharacterBody2D:
	var char = disables.pop_back()
	enables.append(char)
	
	char.visible = true
	char.process_mode = Node.PROCESS_MODE_INHERIT
	
	var char_life : CharLife = char.get_node_or_null("CharLife")
	if char_life:
		char_life.ResetLife()
	
	return char
