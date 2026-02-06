extends Node2D

@export var next_scene_path: String = "res://liv2.tscn"

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$CravattaMeccanico.visible = false
	print ("cravatta")


func _on_next_level_body_entered(body):
	get_tree().call_deferred("change_scene_to_file", next_scene_path)
	
	
