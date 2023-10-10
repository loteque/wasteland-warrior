extends TextureButton

var title_screen_scene: PackedScene = load("res://src/TitleScreen.tscn")

func _ready():
	grab_focus()

func _on_pressed():
	get_tree().change_scene_to_packed(title_screen_scene)
