extends StaticBody2D
@export var chiave1 := 0

@onready var down = $Down
@onready var up = $Up


func _process(delta):
	if chiave1 == 1:
		down.disabled = true
		up.disabled = true
	else:
		down.disabled = false
		up.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_pc_key_body_entered(body: Node2D) -> void:
	chiave1 = 1
	print("aperto: ", chiave1)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	if keyparking == 1:
#		$Down.disabled=true
#		$Up.disabled=true
#	else:
#		$Down.disabled=false
#		$Up.disabled=false
