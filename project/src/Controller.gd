class_name Controller extends Node
## Converts HID inputs into meaningful game intent.
## Provides an interface for any kind of game control

var aim_angle_radians := 0.0

## Gets the rotation in radians needed to aim 
func get_aim_angle(_origin: Node2D) -> float:
	return aim_angle_radians

## Gets the vector for directional control
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
		return _get_motion_vector_from_device(KBL, KBR, KBU, KBD).normalized()

	func get_aim_angle(origin: Node2D) -> float:
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

	func get_motion_vector():
		return Input.get_vector(LSL, LSR, LSU, LSD)
	
	## Returns new angle of stick rotation if the current
	## controller vector not ZERO, else returns the previous value.
	func get_aim_angle(_origin: Node2D) -> float:
		var stick_vector = Input.get_vector(RSL, RSR, RSU, RSD)
		
		if stick_vector != Vector2.ZERO:
			aim_angle_radians = stick_vector.angle()
		
		return aim_angle_radians
