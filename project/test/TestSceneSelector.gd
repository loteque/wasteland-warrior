extends CanvasLayer

@onready var scenes_container = %ScenesContainer
var scenes_dir_path = "res://test/scenarios/"

func _ready():
	var scenes = get_scenes_in_directory(scenes_dir_path)
	add_scene_buttons_to_parent(scenes, scenes_container)

func get_scenes_in_directory(dir_path: String) -> Array:
	var scenes: Array = []
	var dir = DirAccess.open(dir_path)
	
	if dir != null:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):
				print(file_name)
				var scene_path = file_name
				scenes.append(scene_path)
			file_name = dir.get_next()
		
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the directory.")
	
	return scenes
	
func add_scene_buttons_to_parent(scene_paths: Array, parent_node: Node) -> void:
	for scene_path in scene_paths:
		var button = Button.new()
		button.text = scene_path.get_file().get_basename()
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(scenes_dir_path + scene_path))
		parent_node.add_child(button)

func _on_button_pressed(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
	visible = false
	
