extends CanvasLayer

@onready var game_over_dialog: Control = $GameOverDialog

func _ready():
	Signals.connect("player_died", Callable(self, "_on_player_died"))

func show_game_over_dialog():
	game_over_dialog.show()

func _on_player_died():
	show_game_over_dialog()
