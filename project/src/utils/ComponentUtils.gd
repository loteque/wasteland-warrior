extends Node

func has_component(component) -> bool:
	if component:
		return true

	return false

func set_component_property(component, property: String, value, deferred: bool = true):
	if has_component(component) and property in component:
		if deferred: 
			component.set_deferred(property, value)
		else: 
			component.set(property, value)