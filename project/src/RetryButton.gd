extends TextureButton

func _on_pressed():
	remove_mobs()
	get_tree().reload_current_scene()

func remove_mobs():
	var mobs = get_tree().get_nodes_in_group("Mobs")
	for mob in mobs:
		mob.set_physics_process(false)
		mob.queue_free()
