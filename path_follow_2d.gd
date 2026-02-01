extends PathFollow2D



@export var patrol_speed: float = 120.0

var direction: int = 1

var last_position: Vector2

var real_direction: Vector2 = Vector2.ZERO



func _ready():

	last_position = global_position



func _process(delta):



	progress += patrol_speed * delta * direction


# Calcola il vettore direzione reale

	var current_pos = global_position
	if current_pos.distance_to(last_position) > 0.1:

		real_direction = (global_position - last_position).normalized()


	last_position = global_position # Salva la posizione prima del movimento
# Ping-Pong logic

	if progress_ratio >= 1.0: 
		direction = -1

	elif progress_ratio <= 0.0: 
		direction = 1
