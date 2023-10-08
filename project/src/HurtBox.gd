extends Area2D

@export var hurt_group: String

signal took_damage(value: int)

func _on_HurtBox_body_entered(body):
	if body.is_in_group(hurt_group):
		emit_signal("took_damage", body.damage)

func _on_invincibility_component_invincibility_toggled(is_invincible):
	set_monitoring(not is_invincible)
