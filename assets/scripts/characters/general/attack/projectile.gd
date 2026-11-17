class_name Projectile
extends CharacterBody2D

@onready var projectile_life: Timer = $ProjectileLife
@export var living_time_projectile : float = 4
@export var life : life_

var POS:Vector2
var ROT:float
var DIR: float
var SPEED: float = 200

func _ready() -> void:
	spawn()

func spawn() -> void:
	global_position = POS
	global_rotation = ROT
	projectile_life.start(living_time_projectile)

func _physics_process(_delta: float) -> void:
	var colision := move_and_collide(Vector2(SPEED, 0).rotated(DIR) * _delta)
	if colision:
		life.get_damage(2)
		projectile_life.stop()


func _on_projectile_life_timeout() -> void:
	life.get_damage(2)
	projectile_life.stop()
