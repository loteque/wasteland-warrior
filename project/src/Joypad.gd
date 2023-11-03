class_name Joypad

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
