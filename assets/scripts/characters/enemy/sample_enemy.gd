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

const SPEED = 120.0
const DISTANCE_TO_STOP = 20.0

var playerc : PlayerC = null
var follower_to_kill : CharacterBody2D = null
var enemy_state : EnemyStates = EnemyStates.Idle

func SetPlayer(player : PlayerC) -> void:
	playerc = player

func _physics_process(_delta: float) -> void:
	var follow : CharacterBody2D = playerc
	if follower_to_kill:
		follow = follower_to_kill
	var distance = global_position - follow.global_position
	if distance.length() > DISTANCE_TO_STOP:
		var direction = global_position.direction_to(follow.global_position)
		var colision := move_and_collide(direction * SPEED * _delta)
		if colision:
			var collider := colision.get_collider()
			var life_component = collider.get_node_or_null("CharLife")
			if collider is not Enemy and life_component and collider == follow:
				if enemy_state == EnemyStates.WaitToHit:
					return
				else:
					enemy_state = EnemyStates.WaitToHit
					life_component.GetDamage(2)
					hit_timer.start()
	else:
		velocity = Vector2.ZERO

func ResetFollow(char : CharacterBody2D) -> void:
	var char_life = char.get_node_or_null("CharLife")
	if char_life:
		char_life.CharLifeZero.disconnect(ResetFollow)
	follower_to_kill = null


func _on_area_character_entered(char: Node2D) -> void:
	if char is not Enemy:
		if char is PlayerFollower:
			if char != follower_to_kill:
				follower_to_kill = char
				var char_life = char.get_node_or_null("CharLife")
				if char_life:
					if char_life.CharLifeZero.is_connected(ResetFollow):
						return
					char_life.CharLifeZero.connect(ResetFollow)


func _on_hit_timer_timeout() -> void:
	enemy_state = EnemyStates.Running
	hit_timer.stop()
