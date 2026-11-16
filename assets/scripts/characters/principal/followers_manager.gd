class_name followersmanager

var queue_distance: float = 40.0
var cone_size: float = 35.0
var followers : Array[follower_]

func add_follower(follower: follower_) -> void:
	if not followers.has(follower):
		followers.append(follower)
		follower.collision_layer = 2
		follower.collision_mask = 2

func update_followers_positions(player : CharacterBody2D) -> void:
	if followers.size() == 0:
		return
	
	var back = -player.velocity.normalized()
	var right = Vector2(-back.y, back.x)
	
	for i in range(followers.size()):
		var follower = followers[i]
		if not is_instance_valid(follower): continue
		
		var row: int = 1
		var slots_in_row: int = 1
		var count: int = 0

		while count + slots_in_row <= i:
			count += slots_in_row
			row += 1
			slots_in_row += 1
			
		var index_in_row: int = i - count
		
		var offset_lateral: float = index_in_row - (row - 1) / 2.0
		
		var player_pos = player.global_position \
			+ (back * row * queue_distance) \
			+ (right * offset_lateral * cone_size)
		follower.set_player_position(player_pos)
