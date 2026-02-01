extends Control


@export var next_scene_path: String = "res://ggj_splash.tscn"

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	
	await get_tree().create_timer(6.0).timeout
	
	$AnimationPlayer.play("fade_out")
	
	await get_tree().create_timer(3.0).timeout
	
	get_tree().change_scene_to_file(next_scene_path)
