extends Node

@onready var hit_sound = $HitSound2D

func _on_hurt_box_took_damage(value):
	hit_sound.play()
