extends CountComponent

func _ready():
	Signals.connect("cap_collected", Callable(self, "_on_cap_collected"))

func _on_cap_collected():
	count_amount_node.text = str(game_stats.cap_count)
