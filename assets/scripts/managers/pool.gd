class_name pool_
extends Node2D

@onready var POOL: pool_ = $"."
var enables : Array[CharacterBody2D] = []
var disables : Array[CharacterBody2D] = []

func add_to_pool(_char : CharacterBody2D) -> void:
	if enables.has(_char):
		return
	enables.append(_char)

	var char_life = _char.get_node_or_null("Life")
	if char_life:
		if char_life.is_dead.is_connected(disable_character):
			return
		char_life.is_dead.connect(disable_character)

func disable_character(_char : CharacterBody2D) -> void:
	enables.erase(_char)
	if disables.has(_char):
		return
	
	disables.append(_char)
	_char.visible = false
	_char.process_mode = Node.PROCESS_MODE_DISABLED

func has_disabled_list() -> bool:
	return !disables.is_empty()
	
func restore_character() -> CharacterBody2D:
	var _char = disables.pop_back()
	enables.append(_char)
	
	_char.visible = true
	_char.process_mode = Node.PROCESS_MODE_INHERIT
	
	var char_life : life_ = _char.get_node_or_null("Life")
	if char_life:
		char_life.reset_life()
	
	return _char
