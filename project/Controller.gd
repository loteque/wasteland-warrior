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

class Mouse:
	const KBL = "move_left"
	const KBR = "move_right"
	const KBU = "move_up"
	const KBD = "move_down"

class Joypad:
	const RSL = "aim_left"
	const RSR =	"aim_right"
	const RSU = "aim_up"
	const RSD = "aim_down"
	const LSL = "move_left"
	const LSR = "move_right"
	const LSU = "move_up"
	const LSD = "move_down"

	func get_stick_direction_vector(neg_x, pos_x, neg_y, pos_y):
		return Vector2(Input.get_axis(neg_x, pos_x), Input.get_axis(neg_y, pos_y))
	
	func get_rotation(node: Node2D, rotation_angle: float, lerp_weight: float, is_inverted: bool = false):    
		if is_inverted:
			return lerp_angle(node.rotation, -(rotation_angle + PI), lerp_weight)
		
		return lerp_angle(node.rotation, rotation_angle, lerp_weight)
	
	func get_enantiomorphic_rotation(node: Node2D, is_facing_left: bool, dir_vec: Vector2, r_rot: float, l_rot: float):
		if dir_vec != Vector2.ZERO:
			if is_facing_left:
				return l_rot
			else:
				return r_rot
		return node.rotation