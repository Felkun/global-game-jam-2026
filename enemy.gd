extends CharacterBody2D



@export var ghost_path: PathFollow2D

@onready var anim_player = $AnimatedSprite2D



func _physics_process(_delta):

	if not ghost_path: return


# Seguiamo il fantasma

	velocity = ghost_path.real_direction * 150.0 # Usa la velocità dell'NPC

	move_and_slide()


	_update_animation(ghost_path.real_direction)



func _update_animation(dir: Vector2):

	if dir == Vector2.ZERO:

		anim_player.play("front_idle")

		return



	# Determina la direzione prevalente

	if abs(dir.x) > abs(dir.y):

		if dir.x > 0:

			anim_player.flip_h = false

			anim_player.play("side_walk")

		else:

			anim_player.flip_h = true

			anim_player.play("side_walk")

	else:

		if dir.y > 0:

			anim_player.flip_h = false

			anim_player.play("front_walk")

		else:

			anim_player.flip_h = false

			anim_player.play("back_walk")
