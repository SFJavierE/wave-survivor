class_name Projectile
extends CharacterBody2D

var POS:Vector2
var ROT:float
var DIR: float
var SPEED: float = 2000

func _ready() -> void:
	spawn()

func spawn() -> void:
	global_position = POS
	global_rotation = ROT

func _physics_process(delta: float) -> void:
	velocity=Vector2(SPEED, 0).rotated(DIR)
	move_and_slide()
