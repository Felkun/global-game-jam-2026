extends Node2D

@export var next_scene_path: String = "res://credits_splash.tscn"

func _ready() -> void:
	get_tree().change_scene_to_file.call_deferred(next_scene_path)
