extends Node

var Damageable = preload("res://src/utils/Interfaces/Damageable.gd")
var Boostable = preload("res://src/utils/Interfaces/Boostable.gd")

func _get_interface(interface: Variant) -> Variant:
    return interface

func has_valid_interface(node: Node):
    if  not "implements" in node:
        return
    
    var interfaces = node.implements
    for interface in interfaces:
        var target_interface = interface.new()
        for method in target_interface.get_script().get_script_method_list():
            assert(method.name in node, "Invalid interface: " + node.name + " missing method: " + method.name)

func is_implemented(node: Node, interface: Variant):
    var target_interface = interface.new()
    if not "implements" in node:
        return
	
    for node_interface in node.implements:
        if node_interface == _get_interface(interface):
            has_valid_interface(node)
            return

    assert(_get_interface(interface) in node.implements, "Interface error: " + node.name 
    + " does not implement the target interface: " + str(target_interface))
