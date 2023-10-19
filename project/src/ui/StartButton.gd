extends TextureButton

const start_game_scene: PackedScene = preload("res://src/Main.tscn")

func _ready():
	Signals.menu_closed.connect(_on_menu_closed)
	grab_focus()

func start_game():
	get_tree().change_scene_to_packed(start_game_scene)

func _on_pressed():
	start_game()

func _on_menu_closed():
	grab_focus()
