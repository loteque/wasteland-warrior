extends Node
class_name Controller

enum {JOYPAD, MOUSE}
var type: int
var mouse: Mouse
var joypad: Joypad

func _init():
	type = MOUSE
	mouse = Mouse.new()
	joypad = Joypad.new()

func is_mouse():
	return type == Controller.MOUSE

func is_joypad(): 
	return type == Controller.JOYPAD

func get_aim_angle(node: Node2D, is_facing_left: bool):
	# if is_mouse():
	# 	var angle = node.get_angle_to(node.get_global_mouse_position())
	# 	return angle
	
	if is_joypad():
		var direction_vector = joypad.get_stick_direction_vector(
			joypad.RSL, 
			joypad.RSR, 
			joypad.RSU, 
			joypad.RSD
		)
		
		var direction_angle = direction_vector.angle()

		var left_rotation = joypad.get_rotation(
			node, 
			direction_angle, 
			0.5,
			true
		)
		
		var right_rotation = joypad.get_rotation(
			node,
			direction_angle,
			0.5
		)

		return joypad.get_enantiomorphic_rotation(
			node,
			is_facing_left, 
			direction_vector,
			right_rotation, 
			left_rotation
		)

func aim(node: Node2D, is_facing_left: bool):
	if is_joypad():
		node.rotation = get_aim_angle(node, is_facing_left)
	if is_mouse():
		node.look_at(node.get_global_mouse_position())

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
	if is_mouse():
		var motion = _get_motion_vector_from_device(
			mouse.KBL, 
			mouse.KBR, 
			mouse.KBU, 
			mouse.KBD
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
