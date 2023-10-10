extends KeyValueComponent

func _ready():
	Signals.connect("cap_collected", Callable(self, "_on_cap_collected"))
	set_key_text_from_resource(resource, "cap_count")

func _on_cap_collected():
	set_value_text_from_resource(resource, "cap_count")
