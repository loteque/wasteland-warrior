extends Camera2D

@export var target_node_path: NodePath
@export var update_period := 15

@onready var target: Node2D = get_node(target_node_path)

func _physics_process(delta: float) -> void:
	follow(target)
	if is_update_frame():
		Signals.emit_signal("updated_camera_pos", global_position)

func follow(target: Node2D):
	transform.origin = target.transform.origin

func is_update_frame():
	return Engine.get_physics_frames() % update_period == 0
