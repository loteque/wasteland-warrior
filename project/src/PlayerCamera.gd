extends Camera2D


export var update_period := 15

func _physics_process(delta: float) -> void:
	if is_update_frame():
		signal_cam_pos_updated()

func is_update_frame():
	return Engine.get_physics_frames() % update_period == 0

func signal_cam_pos_updated() -> void:
	Signals.emit_signal("updated_camera_pos", global_position)
