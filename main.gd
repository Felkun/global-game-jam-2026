extends Node2D

var keyparking = 0



func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_pc_key_body_entered(body: Node2D) -> void:
	keyparking = 1
