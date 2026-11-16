class_name Enemy
extends CharacterBody2D

enum EnemyStates
{
	WaitToHit,
	Idle,
	Running,
	Dead
}

@onready var hit_timer: Timer = $HitTimer

const SPEED = 100.0
const DISTANCE_TO_STOP = 20.0

var player : player_ = null
var follower_to_kill : CharacterBody2D = null

var enemy_state : EnemyStates = EnemyStates.Idle

func set_player(_player : player_) -> void:
	player = _player

func _physics_process(_delta: float) -> void:
	var follow : CharacterBody2D = player
	if follower_to_kill:
		follow = follower_to_kill
	var distance = global_position - follow.global_position
	if distance.length() > DISTANCE_TO_STOP:
		var direction = global_position.direction_to(follow.global_position)
		var colision := move_and_collide(direction * SPEED * _delta)
		if colision:
			var collider := colision.get_collider()
			var life_component = collider.get_node_or_null("Life")
			if collider is not Enemy and life_component and collider == follow:
				if enemy_state == EnemyStates.WaitToHit:
					return
				else:
					enemy_state = EnemyStates.WaitToHit
					life_component.get_damage(2)
					hit_timer.start()
	else:
		velocity = Vector2.ZERO

func reset_follow(_char : CharacterBody2D) -> void:
	var char_life = _char.get_node_or_null("Life")
	if char_life:
		char_life.is_dead.disconnect(reset_follow)
	follower_to_kill = null


func _on_area_character_entered(_body: Node2D) -> void:
	if _body is not Enemy:
		if _body is follower_:
			if _body != follower_to_kill:
				follower_to_kill = _body
				var char_life = _body.get_node_or_null("Life")
				if char_life:
					if char_life.is_dead.is_connected(reset_follow):
						return
					char_life.is_dead.connect(reset_follow)


func _on_hit_timer_timeout() -> void:
	enemy_state = EnemyStates.Running
	hit_timer.stop()
