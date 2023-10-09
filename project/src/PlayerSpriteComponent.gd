extends AnimatedSprite2D

@onready var sprite_fx_animations = $FXAnimationPlayer

func _on_hurt_box_took_damage(_value):
	sprite_fx_animations.play("Hit Flash")

func _on_health_component_died():
	play("death")
