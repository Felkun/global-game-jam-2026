extends CharacterBody2D

@export var waitTime = 10.0
@onready var anim = $TutaBase
@onready var tie_timer = $TieTimer
@onready var steps_audio = $StepsAudio
@onready var steps_timer = $StepsAudio/StepsAudioTimer
const SPEED = 450.0
enum current_direction { NONE, UP, DOWN, LEFT, RIGHT }
var dir = current_direction.NONE

func _ready() -> void:
	tie_timer.wait_time = waitTime

func player_movement(delta):

	if Input.is_action_pressed("move_up"):
		dir = current_direction.UP
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
		if steps_timer.is_stopped():
			steps_audio.play()
			steps_timer.start()
	elif Input.is_action_pressed("move_down"):
		dir = current_direction.DOWN
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
		if steps_timer.is_stopped():
			steps_audio.play()
			steps_timer.start()
	elif Input.is_action_pressed("move_left"):
		dir = current_direction.LEFT
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
		if steps_timer.is_stopped():
			steps_audio.play()
			steps_timer.start()
	elif Input.is_action_pressed("move_right"):
		dir = current_direction.RIGHT
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
		if steps_timer.is_stopped():
			steps_audio.play()
			steps_timer.start()
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		steps_timer.stop()
	
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
	tie_timer.start()

func _physics_process(delta):
	player_movement(delta)


func _on_area_militare_body_entered(body):
	print ("funge")
	$TutaBase.visible = false
	$TutaMeccanico.visible = false
	$TutaColtivatore.visible = false
	$TutaMilitare.visible = true
	anim = $TutaMilitare
	tie_timer.start()


func _on_area_coltivatore_body_entered(body):
	$TutaBase.visible = false
	$TutaMeccanico.visible = false
	$TutaMilitare.visible = false
	$TutaColtivatore.visible = true
	anim = $TutaColtivatore
	tie_timer.start()


func _on_timer_timeout() -> void:
	$TutaBase.visible = true
	$TutaMeccanico.visible = false
	$TutaMilitare.visible = false
	$TutaColtivatore.visible = false
	anim = $TutaBase
