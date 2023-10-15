@tool
extends KeyValueComponent

func _ready():
	# key.text = resource.get_key("cap_count")
	# value.text = str(resource.get_value("cap_count"))
	Signals.connect("cap_collected", Callable(self, "_on_cap_collected"))
	if Interface.is_implemented(resource, Interface.GettableResource):
		key.text = resource.get_key("cap_count")
		value.text = str(resource.get_value("cap_count"))


func update_cap_count(count: int):
	resource.cap_count = resource.get_value("cap_count") + count
    
func _on_cap_collected():
	update_cap_count(1)
	if Interface.is_implemented(resource, Interface.GettableResource):
		value.text = str(resource.get_value("cap_count"))