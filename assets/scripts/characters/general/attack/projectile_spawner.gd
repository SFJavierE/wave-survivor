class_name projectilespawner
extends Node2D

const PROJECTILE = preload("uid://d35c3vgvjv13v")
@export var pool : pool_ = null

func connect_char_signal(_char : CharacterBody2D):
	var attack_distance = _char.get_node_or_null("Attackdistance")
	if attack_distance:
		attack_distance.fire_projectile.connect(fire)

func update_position_projectile(_projectile : Projectile, shoot_point : Node2D, _come_from_pool: bool) -> void:
	_projectile.DIR = shoot_point.rotation
	_projectile.POS = shoot_point.global_position
	_projectile.ROT = shoot_point.global_rotation
	if _come_from_pool:
		_projectile.spawn()


func fire(shoot_point : Node2D) -> void:
	var projectile : Projectile
	if pool.has_disabled_list():
		projectile = pool.ReturnChar()
		if projectile is Projectile:
			update_position_projectile(projectile, shoot_point, true)
			pool.add_to_pool(projectile)
			projectile.set_process(true)
	else:
		projectile = PROJECTILE.instantiate() as Projectile
		update_position_projectile(projectile, shoot_point, false)
		
		get_parent().add_child(projectile)
		pool.add_to_pool(projectile)
