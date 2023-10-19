extends Node
class_name DebugService

var scene_selector: PackedScene = preload("res://test/TestSceneSelector.tscn")
var debug_menu: CanvasLayer = preload("res://src/ui/UIDebugMenu.tscn").instantiate()
var scene_selector_window: CanvasLayer = scene_selector.instantiate()
var debug_ui_active: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	scene_selector_window.visible = false

func add_debug_window_to_root():
	# This can't be done during the ready function.
	# Possibly specifically when this class is run from an AutoLoad
	var root = get_tree().get_root()
	root.add_child(scene_selector_window)
	root.add_child(debug_menu)

func _process(delta):
	if scene_selector_window.get_parent() == null:
		add_debug_window_to_root()

	if Input.is_action_just_pressed("open_debug"):
		scene_selector_window.visible = !scene_selector_window.visible
		if !scene_selector_window.visible:
			Signals.menu_closed.emit()
	
	if Input.is_action_just_pressed("toggle_debug_ui"):
		debug_menu.visible = !debug_menu.visible
#		debug_ui_active = !debug_ui_active
#		Signals.debug_ui_toggled.emit(debug_ui_active)
