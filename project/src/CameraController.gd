extends Position2D

export(float) var speed = 10.5

func _physics_process(delta: float) -> void:
	signal_cam_pos_updated()
	move(delta)

func move(delta) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta

func signal_cam_pos_updated() -> void:
	if Engine.get_physics_frames() % 15 == 0:
		Signals.emit_signal("updated_camera_pos", global_position)