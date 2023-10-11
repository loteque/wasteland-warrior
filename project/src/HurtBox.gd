extends Area2D
class_name HurtBox

@export var hurt_group: String

#Is it better to directly access the sibling instead of using a signal?
#I noticed it makes the connection more visible.
#I could see a senario where a user adds components and then doesn't
#see which signals to connect and where they should be connected.
#By exporting the dependancy and then using the has_componet method,
#We can show in-editor what componets this component works with but 
#not crash the game if the component reference is not needed and not referenced.
#It might be slightly faster as well.
#@export var invincibility_component: InvincibilityComponent

signal took_damage(value: int)

# Candidate for Component Class or global helper function
# func has_component(component) -> bool:
# 	if component:
# 		return true
# 	return false

# Candidate for Component Class or global helper function
# func set_component_property(component, property: String, value, deferred: bool = true):
# 	if has_component(component) and property in component:
# 		if deferred: 
# 			component.set_deferred(property, value)
# 		else: 
# 			component.set(property, value)

func _on_HurtBox_body_entered(body):
	if body.is_in_group(hurt_group):
		took_damage.emit(body.damage)
#		set_component_property(invincibility_component, is_invulnerable, true, false)

func _on_health_component_died():
	set_deferred("monitoring", false)
