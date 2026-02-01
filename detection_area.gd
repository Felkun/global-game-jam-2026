extends Area2D
#@export var player_chased = false
#
#func _on_detection_area_body_entered(body):
	#if body.name.to_lower() == "player" or body.is_in_group("player"):
		#get_tree().reload_current_scene()
	#
#func _on_detection_area_body_exited(body):
	#player_chased = false
	
