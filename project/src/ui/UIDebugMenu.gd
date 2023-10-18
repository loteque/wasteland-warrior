extends CanvasLayer

func _ready():
	Signals.debug_ui_toggled.connect(Callable(self, "_on_debug_toggled"))

func _on_debug_toggled(is_active: bool):
	visible = is_active
