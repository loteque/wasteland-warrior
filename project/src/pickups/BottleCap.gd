extends Node2D

@onready var sprite = $CapAnimatedSprite

func _process(delta):
	sprite.play("default")
