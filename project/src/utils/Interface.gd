extends Node

#Interface Defenition Files
var Damageable = preload("res://src/utils/Interfaces/Damageable.gd")
var Boostable = preload("res://src/utils/Interfaces/Boostable.gd")
var ConfigurableNode = preload("res://src/utils/Interfaces/ConfigurableNode.gd")
var GettableResource = preload("res://src/utils/Interfaces/GettableResource.gd")

func _get_interface(interface: Variant) -> Variant:
    return interface

func has_valid_interface(object: Object):
    if  not "implements" in object:
        return false
    
    var interfaces = object.implements
    for interface in interfaces:
        var target_interface = interface.new()
        for method in target_interface.get_script().get_script_method_list():
            assert(method.name in object, "Invalid interface: " 
            + object.get_script().get_instance_base_type() 
            + " missing method: " + method.name)

func is_implemented(object: Object, interface: Variant):
    var target_interface = interface.new()
    if not "implements" in object:
        return false
	
    for object_interface in object.implements:
        if object_interface == _get_interface(interface):
            has_valid_interface(object)
            return true

    assert(_get_interface(interface) in object.implements, "Interface error: " 
    + object.get_script().get_instance_base_type() 
    + " does not implement the target interface: " + str(target_interface))
