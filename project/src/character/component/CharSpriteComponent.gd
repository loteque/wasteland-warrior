extends AnimatedSprite2D
class_name CharSpriteComponent

@export var fx: AnimationPlayer

func play_hit_flash():
	fx.play("hit_flash")

func play_death():
	play("death")
