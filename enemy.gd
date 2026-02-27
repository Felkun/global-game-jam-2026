extends CharacterBody2D


@export_enum("Up", "Down", "Left", "Right") var initial_direction: String = "Down"
@export var ghost_path: PathFollow2D

@onready var anim_player = $AnimatedSprite2D
@onready var detection_area = $DetectionArea
@onready var shapecast = $ShapeCast2D
@onready var exclamation_point = $ExclamationPoint
@onready var detection_sound = $DetectionSound
@onready var detection_sound_cooldown = $DetectionSound/DetectionSoundCooldown

var player_in_range = null

func _ready() -> void:
	exclamation_point.visible = false
	#the shapecast will ignore enemy body as collider
	shapecast.add_exception(self)
	shapecast.add_exception(detection_area)
	shapecast.enabled = true
	_set_idle_position()
	detection_sound_cooldown.wait_time = 4.0

func _physics_process(_delta):

	if ghost_path:
		var dir = ghost_path.real_direction
		velocity = dir * 150.0
		
	#implementation shapecast to avoid detection behind walls

	if player_in_range != null:

		var target_vec = shapecast.to_local(player_in_range.global_position)
		shapecast.target_position = target_vec * 1.1
		shapecast.force_shapecast_update()
		print("pre colliding check")
		if shapecast.is_colliding():
			for i in shapecast.get_collision_count():
				var collider = shapecast.get_collider(i)
				print("Shape collided with: ", shapecast.get_collider(i).name)
				if collider == player_in_range || collider.name == "DetectionHitbox":
					print("GOTCHA CON SHAPECAST")
					on_detection()
		else:
			var dist = shapecast.global_position.distance_to(player_in_range.global_position)
			print("Non colpisco nulla. Distanza dal player: ", dist, " Lunghezza raggio: ", shapecast.target_position.length())
			

# Seguiamo il fantasma
	if not ghost_path:
		return
	velocity = ghost_path.real_direction * 150.0 # Usa la velocità dell'NPC

	move_and_slide()


	_update_animation(ghost_path.real_direction)

func on_detection():
	if detection_sound_cooldown.is_stopped():
		detection_sound.play()
		detection_sound_cooldown.start()
	exclamation_point.visible = true
	await get_tree().create_timer(0.7).timeout
	get_tree().call_deferred("reload_current_scene")
	

func _update_animation(dir: Vector2):

	if dir == Vector2.ZERO:

		anim_player.play("front_idle")

		return



	# Determina la direzione prevalente

	if abs(dir.x) > abs(dir.y):

		if dir.x > 0:

			anim_player.flip_h = false

			anim_player.play("side_walk")
			
			detection_area.rotation_degrees = 0

		else:

			anim_player.flip_h = true

			anim_player.play("side_walk")
			detection_area.rotation_degrees = 180

	else:

		if dir.y > 0:

			anim_player.flip_h = false

			anim_player.play("front_walk")
			
			detection_area.rotation_degrees = 90

		else:

			anim_player.flip_h = false

			anim_player.play("back_walk")
			detection_area.rotation_degrees = 270

func _set_idle_position():
	match initial_direction:
		"Up":
			anim_player.flip_h = false
			anim_player.play("back_idle")
			detection_area.rotation_degrees = 270
		"Down":
			anim_player.flip_h = false
			anim_player.play("front_idle")
			detection_area.rotation_degrees = 90
		"Left":
			anim_player.flip_h = true
			anim_player.play("side_idle")
			detection_area.rotation_degrees = 180
		"Right":
			anim_player.flip_h = false
			anim_player.play("side_idle")
			detection_area.rotation_degrees = 0

func _on_detection_area_body_entered(body):
	if body.name.to_lower() == "player" or body.is_in_group("player"):
		var tuta = body.get_node("TutaMeccanico")
		if tuta.visible == false:
			print("Visible:", tuta.visible)
			player_in_range = body
			
func _on_detection_area_body_exited(body):
	if body.name.to_lower() == "player" or body.is_in_group("player"):
		player_in_range = null
