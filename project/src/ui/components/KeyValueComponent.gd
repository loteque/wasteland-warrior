class_name KeyValueComponent
extends Control

@export var resource: GameStatsResource:
	get:
		return resource
	set(var_value):
		resource = var_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

@export var key: Label:
	get:
		return key
	set(key_value):
		key = key_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

@export var value: Label:
	get:
		return value
	set(val_value):
		value = val_value
		if Engine.is_editor_hint():
				update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = PackedStringArray()
	var resource_warn: String = "Add a GameStatsResource"
	var key_warn: String = "add a Label node for key"
	var value_warn: String = "add a Label node for value"

	if not resource:
		warnings.append(resource_warn)
	if not key:
		warnings.append(key_warn)
	if not value:
		warnings.append(value_warn)

	return warnings


## Sets the text element of the value label given a resource (res) and var member name (res_key) of the resource.
func set_value_text_from_resource(res: Resource, res_key: String):
	if res and res.has_method("get_value"):
		value.text = str(res.get_value(res_key))

## Sets the text element of the key label given a resource (res) and var member name (res_key) of the resource.
func set_key_text_from_resource(res: Resource, res_key: String):
	if res and res_key in res:
		key.text = str(res_key)

func set_value_text(text: String):
	if value:
		value.text = text
