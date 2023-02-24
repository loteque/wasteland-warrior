extends Node2D

func pickup():
	queue_free()

func _on_PickupArea_body_entered(body):
	if body.is_in_group("player"):
		pickup()
