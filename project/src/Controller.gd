class_name Controller extends Node
# Converts HID inputs into meaningful game intent.
# Provides an interface for any kind of game control

func get_move_vector() -> Vector2:
	return Vector2.ZERO

func get_aim(origin: Node2D) -> float:
	return 0.0

func is_keyboard_mouse() -> bool:
	return false

func is_joypad() -> bool: 
	return false

# Gets the vector for directional control
func get_motion_vector() -> Vector2:
	return Vector2.ZERO

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


class KeyboardMouse extends Controller:

	const KBL = "move_left"
	const KBR = "move_right"
	const KBU = "move_up"
	const KBD = "move_down"

	func get_motion_vector() -> Vector2:
		return _get_motion_vector_from_device(KBL, KBR, KBU, KBD)

	func get_aim(origin: Node2D) -> float:
		return origin.get_angle_to(origin.get_global_mouse_position())


class Joypad extends Controller:

	const RSL = "aim_left"
	const RSR =	"aim_right"
	const RSU = "aim_up"
	const RSD = "aim_down"
	const LSL = "move_left"
	const LSR = "move_right"
	const LSU = "move_up"
	const LSD = "move_down"

	func is_keyboard_mouse():
		return false

	func is_joypad():
		return true

	func get_motion_vector():
		return _get_motion_vector_from_device(LSL, LSR, LSU, LSD)

	func get_stick_direction_vector(neg_x, pos_x, neg_y, pos_y) -> Vector2:
		return Vector2(Input.get_axis(neg_x, pos_x), Input.get_axis(neg_y, pos_y))

	func _get_right_stick_angle() -> float:
		return get_stick_direction_vector(RSL, RSR, RSU, RSD).angle()

	func get_aim(origin: Node2D) -> float:
		return _get_right_stick_angle()
