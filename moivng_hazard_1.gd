extends AnimatableBody3D
@export var final_destination : Vector3
@export var how_long : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"global_position",global_position + final_destination,how_long)
	tween.tween_property(self,"global_position",  global_position ,how_long)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
