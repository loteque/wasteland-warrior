extends ProgressBar
class_name HealthBar

@onready var max_label: Label = %HealthMaxLabel
@onready var value_label: Label = %HealthValueLabel

func _ready():
	Signals.player_health_changed.connect(Callable(self, "_on_player_health_changed"))
	Signals.player_max_health_changed.connect(Callable(self, "_on_player_max_health_changed"))
	value_label.text = str(value)
	max_label.text = str(max_value)

func _on_player_health_changed(new_health: int):
	value = new_health
	value_label.text = str(new_health)

func _on_player_max_health_changed(new_max_health: int):
	max_value = new_max_health
	max_label.text = str(new_max_health)

func _on_value_changed(value: float):
	value_label.text = str(int(value))

func _on_changed():
	max_label.text = str(int(max_value))
