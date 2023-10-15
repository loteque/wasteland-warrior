extends Resource
class_name GameStatsResource

var implements = [Interface.GettableResource]

@export var cap_count: int = 0

func get_value(property_name: String) -> Variant:
    if has_value(property_name):
        var value = get(property_name)
        return value
    return null

func get_key(property_name: String) -> String:
    if has_property(property_name):
        return property_name
    return ""

func has_property(property_name: String) -> bool:
    if self.get(property_name):
        return true
    return false

func has_value(property_name: String) -> bool:
    if get(property_name):
        return true
    return false
