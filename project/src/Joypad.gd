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

func get_right_stick_angle() -> float:
	return get_stick_direction_vector(RSL, RSR, RSU, RSD).angle()
