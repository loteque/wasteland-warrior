extends Node2D

func pickup():
	Signals.emit_signal("cap_collected")
	queue_free()

func _on_PickupArea_body_entered(body):
	if body.is_in_group("player"):
		pickup()
