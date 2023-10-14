extends AnimatedSprite2D
class_name CharSpriteComponent

@export var fx: AnimationPlayer

func _on_health_component_died():
	play("death")
