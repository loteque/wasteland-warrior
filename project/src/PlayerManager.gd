extends Node

var current_controller
var joypad
var keyboard_mouse

func _ready():
	var controller = Controller.new()
	joypad = controller.Joypad.new()
	keyboard_mouse = controller.KeyboardMouse.new()
	current_controller = keyboard_mouse

func get_controller() -> Controller:
	return current_controller

func _unhandled_input(event):
	if event is InputEventJoypadMotion:
		current_controller = joypad

	if event is InputEventKey or event is InputEventMouseMotion:
		current_controller = keyboard_mouse
