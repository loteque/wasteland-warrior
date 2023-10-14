extends Node
class_name CharSoundComponent

@onready var hit_sound = $HitSound2D

func play_hit_sound():
	hit_sound.play()
