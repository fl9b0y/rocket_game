extends RigidBody3D
func movement(delta) ->void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.y*delta*1000)
	if Input.is_action_pressed("ui_down"):
		apply_central_force(-basis.y*delta*1000)
	if Input.is_action_pressed("ui_right"):
		apply_torque(basis.z*delta*1000)
	if Input.is_action_pressed("ui_left"):
		apply_torque(basis.z*delta*1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
