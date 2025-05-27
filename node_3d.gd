extends RigidBody3D
func movement(delta) ->void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.y*delta*1000)
	if Input.is_action_pressed("ui_down"):
		apply_central_force(-basis.y*delta*1000)
	if (Input.is_action_pressed("ui_right") )and (Input.is_action_pressed("ui_up")) :
		apply_torque(-basis.z*delta*1000)
	if ( Input.is_action_pressed("ui_left")) and (Input.is_action_pressed("ui_up")):
		apply_torque(basis.z*delta*1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)
	


func _on_body_entered(body: Node) -> void:
	print(body.name)
	if "Win" in body.get_groups() :
		win_sequecne()
	if "Lose" in body.get_groups():
		crash_sequence()
		

func win_sequecne()-> void:
	print("you win ")
	
func crash_sequence()-> void:
	print("you lose ")
	get_tree().reload_current_scene()
