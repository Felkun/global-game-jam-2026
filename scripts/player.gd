extends CharacterBody2D

@onready var anim = $TutaBase


const SPEED = 450.0
enum current_direction { NONE, UP, DOWN, LEFT, RIGHT }
var dir = current_direction.NONE

func player_movement(delta):

	if Input.is_action_pressed("move_up"):
		dir = current_direction.UP
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("move_down"):
		dir = current_direction.DOWN
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("move_left"):
		dir = current_direction.LEFT
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_right"):
		dir = current_direction.RIGHT
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	
	
	if dir == current_direction.RIGHT:
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == current_direction.LEFT:
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == current_direction.UP:
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
			
	elif dir == current_direction.DOWN:
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
		
	else:
		anim.play("front_idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print ("funge")
	$TutaBase.visible = false
	$TutaMeccanico.visible = true
	anim = $TutaMeccanico
	

func _physics_process(delta):
	player_movement(delta)


func _on_area_militare_body_entered(body):
	print ("funge")
	$TutaBase.visible = false
	$TutaMeccanico.visible = false
	$TutaColtivatore.visible = false
	$TutaMilitare.visible = true
	anim = $TutaMilitare


func _on_area_coltivatore_body_entered(body):
	$TutaBase.visible = false
	$TutaMeccanico.visible = false
	$TutaMilitare.visible = false
	$TutaColtivatore.visible = true
	anim = $TutaColtivatore
