extends AnimatedSprite2D

@onready var sprite_fx_animations = $FXAnimationPlayer

func _on_hurt_box_took_damage(value):
	sprite_fx_animations.play("Hit Flash")
