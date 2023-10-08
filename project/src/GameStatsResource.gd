extends Resource
class_name GameStatsResource

@export var cap_count := 0

func _init():
    Signals.connect("cap_collected", Callable(self, "_on_cap_collected"))

func update_cap_count(count: int):
    cap_count = cap_count + count

func _on_cap_collected():
    update_cap_count(1)