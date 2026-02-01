extends Node2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
		$CravattaMeccanico.visible = false
		 


func _on_next_level_body_entered(body):
	get_tree().change_scene_to_file("res://liv2.tscn")
	
	
