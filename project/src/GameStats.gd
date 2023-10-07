extends Node

@export var cap_count := 0

func _ready():
	Signals.connect("cap_collected", Callable(self, "_on_cap_collected"))

func _on_cap_collected():
	cap_count += 1
	Signals.emit_signal("count_updated", cap_count)
