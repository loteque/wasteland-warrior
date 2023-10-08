extends Node
class_name InvincibilityComponent

@export var invincibility_duration := 2.0

@onready var timer: Timer = $Timer

signal invincibility_toggled(is_invincible)

func enable_invincibility():
	emit_signal("invincibility_toggled", true)
	timer.start(invincibility_duration)

func _on_Timer_timeout():
	emit_signal("invincibility_toggled", false)

func _on_hurt_box_took_damage(value):
	enable_invincibility()
