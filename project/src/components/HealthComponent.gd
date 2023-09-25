extends Node
class_name HealthComponent

export var MAX_HEALTH: float setget set_max_health
export var MIN_HEALTH := 0.0

onready var health := MAX_HEALTH setget set_health, get_health

func set_max_health(value):
	if value > MIN_HEALTH:
		MAX_HEALTH = value

func get_max_health():
	return MAX_HEALTH

func set_health(value):
	health = clamp(value, MIN_HEALTH, MAX_HEALTH)

func get_health():
	return health
	
func heal(value):
	set_health(health + value)

func damage(value):
	set_health(health - value)
