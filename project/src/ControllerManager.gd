extends Node
## A global that is used to manage controllers.

var current_controller: Controller
var joypad: Controller.Joypad
var keyboard_mouse: Controller.KeyboardMouse

func get_controller() -> Controller:
	return current_controller

func _ready() -> void:
	var controller = Controller.new()
	joypad = controller.Joypad.new()
	keyboard_mouse = controller.KeyboardMouse.new()
	current_controller = keyboard_mouse

func _unhandled_input(event) -> void:
	if event is InputEventJoypadMotion:
		current_controller = joypad

	if event is InputEventKey:
		current_controller = keyboard_mouse
	
	if event is InputEventMouseMotion && event.relative != Vector2.ZERO:
		current_controller = keyboard_mouse
