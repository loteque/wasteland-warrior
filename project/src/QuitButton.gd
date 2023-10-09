extends TextureButton

var title_screen_scene: PackedScene = load("res://src/TitleScreen.tscn")

func _ready():
	grab_focus()

func quit():
	remove_mobs()
	get_tree().change_scene_to_packed(title_screen_scene)

func _on_pressed():
	quit()

func remove_mobs():
	var mobs = get_tree().get_nodes_in_group("Mobs")
	for mob in mobs:
		mob.set_physics_process(false)
		mob.queue_free()
