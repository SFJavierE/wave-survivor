class_name FollowerManager

var DISTANCIA_FILA: float = 40.0
var APERTURA_CONO: float = 35.0
var followers : Array[PlayerFollower]

func AddFollower(follower: PlayerFollower) -> void:
	if not followers.has(follower):
		followers.append(follower)
		follower.collision_layer = 2
		follower.collision_mask = 2

func UpdateFollowerPosition(leader : CharacterBody2D) -> void:
	if followers.size() == 0:
		return
	
	var back = -leader.velocity.normalized()
	var right = Vector2(-back.y, back.x)
	
	for i in range(followers.size()):
		var f = followers[i]
		if not is_instance_valid(f): continue
		
		var row: int = 1
		var slots_in_row: int = 1
		var count: int = 0
		
		# Averiguamos matemáticamente en qué fila cae el índice 'i'
		# Fila 1: 1 asiento | Fila 2: 2 asientos | Fila 3: 3 asientos...
		while count + slots_in_row <= i:
			count += slots_in_row
			row += 1
			slots_in_row += 1 # Cada fila consecutiva es más ancha y aloja un seguidor más
			
		# Posición horizontal del seguidor dentro de su fila actual (de 0 a row-1)
		var index_in_row: int = i - count
		
		# Centramos los asientos distribuyéndolos simétricamente respecto al eje central
		var offset_lateral: float = index_in_row - (row - 1) / 2.0
		# -------------------------------
		
		# Calcular el punto matemático exacto del cono relleno en el mapa
		var target_pos = leader.global_position \
			+ (back * row * DISTANCIA_FILA) \
			+ (right * offset_lateral * APERTURA_CONO)
		f.SetFollowing(target_pos)
