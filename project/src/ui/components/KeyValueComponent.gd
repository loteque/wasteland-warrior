class_name KeyValueComponent
extends Control

var implements =  [Interface.ConfigurableNode]

var resource_warn: String = "Add a GameStatsResource"
@export var resource: GameStatsResource:
	get:
		return resource
	set(resource_value):
		resource = resource_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

var key_warn: String = "add a Label node for key"
@export var key: Label:
	get:
		return key
	set(key_value):
		key = key_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

var value_warn: String = "add a Label node for value"
@export var value: Label:
	get:
		return value
	set(val_value):
		value = val_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var properties: Array = [resource, key, value]
	var warning_strings: Array = [resource_warn, key_warn, value_warn]
	var warnings: PackedStringArray = compile_warnings(properties, warning_strings)
	return warnings

func compile_warnings(properties: Array, warning_strings: Array) -> PackedStringArray:
	var warnings: PackedStringArray = PackedStringArray()
	var i: int = 0
	for property in properties:
		if not property:
			warnings.append(warning_strings[i])
			i += 1 
	return warnings