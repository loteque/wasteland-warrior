extends Node
class_name Controller

enum {JOYPAD, KEYBOARD_MOUSE}
var type: int
var keyboard_mouse: Mouse
var joypad: Joypad

func _init():
	type = KEYBOARD_MOUSE
	keyboard_mouse = Mouse.new()
	joypad = Joypad.new()

func is_keyboard_mouse():
	return type == Controller.KEYBOARD_MOUSE

func is_joypad(): 
	return type == Controller.JOYPAD

func _get_motion_vector_from_device(neg_x, pos_x, neg_y, pos_y):
	var motion: Vector2 = Vector2.ZERO
	if Input.is_action_pressed(neg_y):
		motion.y -= 1

	if Input.is_action_pressed(pos_y):
		motion.y += 1
		
	if Input.is_action_pressed(neg_x):
		motion.x -= 1

	if Input.is_action_pressed(pos_x):
		motion.x += 1
		
	return motion

func get_motion_vector():
	if is_keyboard_mouse():
		var motion = _get_motion_vector_from_device(
			keyboard_mouse.KBL, 
			keyboard_mouse.KBR, 
			keyboard_mouse.KBU, 
			keyboard_mouse.KBD
		)
		return motion

	if is_joypad():
		var motion = _get_motion_vector_from_device(
			joypad.LSL,
			joypad.LSR,
			joypad.LSU,
			joypad.LSD
		)
		return motion

	return 0

func move(node: CharacterBody2D, speed):
	var motion: Vector2 = get_motion_vector()
	motion = motion.normalized() * speed
	node.set_velocity(motion)
	node.move_and_slide()

func aim(node:Node2D) -> float:
	if is_joypad():
		return joypad.get_right_stick_angle()
	if is_keyboard_mouse():
		return node.get_angle_to(node.get_global_mouse_position())
	return 0.0
	
