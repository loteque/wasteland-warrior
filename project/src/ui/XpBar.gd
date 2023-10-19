extends ProgressBar
class_name XpBar

@onready var max_label: Label = %XpMaxLabel
@onready var value_label: Label = %XpValueLabel

func _ready():
	Signals.leveled_up.connect(Callable(self, "_on_leveled_up"))
	Signals.xp_updated.connect(Callable(self, "_on_xp_updated"))

func _on_xp_updated(xp_count: int):
	value = xp_count

func _on_leveled_up(new_level, xp_count, xp_for_next_level):
	value = xp_count
	min_value = xp_count
	max_value = xp_for_next_level

func _on_value_changed(new_value: float):
	value_label.text = str(new_value)

func _on_max_changed():
	max_label.text = str(max_value)
