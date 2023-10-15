extends Area2D
class_name PickupComponent

@export var signal_name: String
@export var deletion_target: Node

func pickup():
	Signals.emit_signal(signal_name)
	deletion_target.queue_free()

func _on_PickupArea_body_entered(body: Node2D):
	if body.is_in_group("player") and body.has_method("collect"):
		body.collect()
		pickup()
