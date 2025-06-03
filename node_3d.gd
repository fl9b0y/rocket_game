extends RigidBody3D
@onready var death: AudioStreamPlayer = $death
@onready var success: AudioStreamPlayer = $success
@onready var engine_thrust: AudioStreamPlayer3D = $engine_thrust
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var left_booster: GPUParticles3D = $left_booster
@onready var r_rocket_booster: GPUParticles3D = $r_rocket_booster
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles



var is_transitioning : bool = false
func movement(delta) ->void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.y*delta*1000)
		if engine_thrust.playing == false:
			engine_thrust.play()
			booster_particles.emitting = true
	else:
		engine_thrust.stop()
		booster_particles.emitting = false
	if Input.is_action_pressed("ui_down"):
		apply_central_force(-basis.y*delta*1000)
	if (Input.is_action_pressed("ui_right") )and (Input.is_action_pressed("ui_up")) :
		apply_torque(-basis.z*delta*1000)
		r_rocket_booster.emitting = true
	else:
		r_rocket_booster.emitting = false
	if ( Input.is_action_pressed("ui_left")) and (Input.is_action_pressed("ui_up")):
		apply_torque(basis.z*delta*1000)
		left_booster.emitting = true
	else:
		left_booster.emitting = false


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
	success_particles.emitting = true
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level))
	
	
func crash_sequence()-> void:
	print("you lose ")
	explosion_particles.emitting = true
	death.play()
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().reload_current_scene)
