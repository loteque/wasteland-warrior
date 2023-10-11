extends Node
class_name InvincibilityComponent

@export var invulnerable_duration := 5.0
@export var hurt_box_component: HurtBox

@onready var timer: Timer = $Timer

@onready var is_invulnerable: bool = false:
	get:
		print("get is_invulenerable: " + str(is_invulnerable))
		return is_invulnerable
	set(value):
		print("set is_invulnerable: " + str(value))
		if value == true:
			set_component_property(hurt_box_component, "monitoring", false)
			timer.start(invulnerable_duration)
			is_invulnerable = value
		else:
			is_invulnerable = value

# Candidate for Component Class or global helper function
func has_component(component) -> bool:
	if component:
		return true
	
	return false

# Candidate for Component Class or global helper function
func set_component_property(component, property: String, value, deferred: bool = true):
	if has_component(component) and property in component:
		if deferred: 
			component.set_deferred(property, value)
		else: 
			component.set(property, value)

func _on_Timer_timeout():
	is_invulnerable = false
	set_component_property(hurt_box_component, "monitoring", true)

func _on_hurt_box_took_damage(_value):
	is_invulnerable = true
