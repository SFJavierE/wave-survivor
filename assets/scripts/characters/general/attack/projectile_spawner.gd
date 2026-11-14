class_name ProjectileSpawner
extends Node2D

const PROJECTILE = preload("uid://d35c3vgvjv13v")
@export var pool : PoolChar = null

func update_position_projectile(projectile : Projectile, char : CharacterBody2D, come_from_pool: bool) -> void:
	projectile.DIR = char.rotation
	projectile.POS = char.global_position
	projectile.ROT = char.global_rotation
	if come_from_pool:
		projectile.spawn()


func fire_projectile(char : CharacterBody2D) -> void:
	var projectile : Projectile
	if pool.DisableCharHasElements():
		projectile = pool.ReturnChar()
		if projectile is Projectile:
			update_position_projectile(projectile, char, true)
			pool.AddCharToPool(projectile)
			projectile.set_process(true)
	else:
		projectile = PROJECTILE.instantiate() as Projectile
		update_position_projectile(projectile, char, false)
		
		get_parent().add_child(projectile)
		pool.AddCharToPool(projectile)
