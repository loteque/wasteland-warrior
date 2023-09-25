extends Control

@onready var cap_count_label = $HBoxContainer/CapCountLabel

func _ready():
	Signals.connect("cap_count_updated", Callable(self, "_on_cap_count_updated"))

func _on_cap_count_updated(count: int):
	cap_count_label.text = str(count)
