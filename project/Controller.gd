extends Node
class_name Controller

enum {JOYPAD, MOUSE}
var type: int
var dev_id: int
var dev_guid: String
var player_id: int

func is_mouse():
	return type == Controller.MOUSE

func is_joypad(): 
	return type == Controller.JOYPAD

class Mouse:
	pass

class Joypad:
	const RSL = "aim_left"
	const RSR =	"aim_right"
	const RSU = "aim_up"
	const RSD = "aim_down"
	
	func get_right_stick_direction_vector():
		return Vector2(Input.get_axis(RSL, RSR), Input.get_axis(RSU, RSD))
	
	func get_right_stick_rotation(node: Node2D, rotation_angle, lerp_weight):    
		return lerp_angle(node.rotation, -(rotation_angle + PI), lerp_weight)

	func get_right_stick_inverse_rotation(node: Node2D, rotation_angle, lerp_weight):
		return lerp_angle(node.rotation, rotation_angle, lerp_weight)
