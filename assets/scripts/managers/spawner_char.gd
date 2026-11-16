class_name spawnercharacters

extends Node2D

@export var follow_player : bool = false
@export var player : player_ = null

@export var char_to_spawn : PackedScene = null

@export var time_to_spawn : float = 5
@export var limit_to_spawn : int = 100
@onready var SPAWNER_TIMER: Timer = $SpawnerTimer

@export var spawn_buffer: float = 100.0

@export var pool : pool_ = null

func _ready() -> void:
	SPAWNER_TIMER.start(time_to_spawn)

func spawn_char() -> void:
	if not is_instance_valid(player) or not char_to_spawn:
		return

	var viewport_size = get_viewport_rect().size

	var cam_left = player.global_position.x - (viewport_size.x / 2.0)
	var cam_right = player.global_position.x + (viewport_size.x / 2.0)
	var cam_top = player.global_position.y - (viewport_size.y / 2.0)
	var cam_bottom = player.global_position.y + (viewport_size.y / 2.0)

	var side = randi() % 4
	var spawn_pos = Vector2.ZERO

	if side == 0: # Top
			spawn_pos.x = randf_range(cam_left - spawn_buffer, cam_right + spawn_buffer)
			spawn_pos.y = cam_top - spawn_buffer
	else: if 1: # Bottom
			spawn_pos.x = randf_range(cam_left - spawn_buffer, cam_right + spawn_buffer)
			spawn_pos.y = cam_bottom + spawn_buffer
	else: if 2: # Left
			spawn_pos.x = cam_left - spawn_buffer
			spawn_pos.y = randf_range(cam_top - spawn_buffer, cam_bottom + spawn_buffer)
	else: if 3: # Right
			spawn_pos.x = cam_right + spawn_buffer
			spawn_pos.y = randf_range(cam_top - spawn_buffer, cam_bottom + spawn_buffer)

	var char_instant : CharacterBody2D

	if pool.has_disabled_character():
		char_instant = pool.restore_character()
		char_instant.global_position = spawn_pos
		pool.add_to_pool(char_instant)
		char_instant.set_process(true)
	else:
		char_instant = char_to_spawn.instantiate() as CharacterBody2D
		char_instant.global_position = spawn_pos
		
		get_parent().add_child(char_instant)
		pool.add_to_pool(char_instant)

	if follow_player:
		char_instant.set_player(player)

func _on_spawner_timer_timeout() -> void:
	spawn_char()
