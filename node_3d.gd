extends RigidBody3D
@onready var death: AudioStreamPlayer = $death
@onready var success: AudioStreamPlayer = $success
@onready var engine_thrust: AudioStreamPlayer3D = $engine_thrust



var is_transitioning : bool = false
func movement(delta) ->void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.y*delta*1000)
		if engine_thrust.playing == false:
			engine_thrust.play()
	else:
		engine_thrust.stop()
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
	if is_transitioning == false:
		if "Win" in body.get_groups() :
			win_sequecne(body.next_level)
		if "Lose" in body.get_groups():
			crash_sequence()
			

func win_sequecne(next_level:String)-> void:
	print("you win ")
	success.play()
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level))
	
	
func crash_sequence()-> void:
	print("you lose ")
	death.play()
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().reload_current_scene)
