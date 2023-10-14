extends Area2D
class_name HurtBoxComponent

@export var hurt_group: String

signal took_damage(value: int)

func stop_monitoring():
	set_deferred("monitoring", false)

func start_monitoring():
	set_deferred("monitoring", true)

func take_damage(value: int):
	took_damage.emit(value)
