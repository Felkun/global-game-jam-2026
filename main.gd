extends Node2D

var keyparking = 0


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if keyparking == 1:
		$Down.disabled=true
		$Up.disabled=true
	else:
		$Down.disabled=false
		$Up.disabled=false

func _on_area_pc_key_body_entered(body: Node2D) -> void:
	keyparking = 1
	print(keyparking)
	
