extends Area2D
class_name PickupComponent

@export var game_stats: GameStatsResource
@export var signal_name: String
@export var deletion_target: Node

func pickup():
	game_stats.update_cap_count(1)
	Signals.emit_signal(signal_name)
	deletion_target.queue_free()

func _on_PickupArea_body_entered(body):
	if body.is_in_group("player"):
		pickup()
