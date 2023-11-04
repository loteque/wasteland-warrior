extends Control


# Called when the node enters the scene tree for the first time.

@onready var test_controls = $"."
@onready var joypad_test_indicator = $JoypadTestIndicator
@onready var joypad_right_stick_angle_label = $JoypadRightStickAngleLabel
@onready var joypad_right_stick_x_strength = $JoypadRightStickXStrength
@onready var joypad_right_stick_y_strength = $JoypadRightStickYStrength

@onready var joypad_test_indicator_normalized = $JoypadTestIndicatorNormalized
@onready var joypad_right_stick_normalized_angle_label = $JoypadRightStickNormalizedAngleLabel
@onready var joypad_right_stick_method_angle_label = $JoypadRightStickMethodAngleLabel
@onready var joypad_test_indicator_method = $JoypadTestIndicatorMethod


var controller

func _ready():
	controller = Controller.Joypad.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_aim()
	joypad_test_indicator_normalized.rotation = get_normalized_vector_angle()
	joypad_right_stick_angle_label.text = str(joypad_test_indicator.rotation)
	joypad_right_stick_normalized_angle_label.text = str(get_normalized_vector_angle())
	joypad_right_stick_x_strength.text = str(get_x_val())
	joypad_right_stick_y_strength.text = str(get_y_val())
	var vector = Input.get_vector(controller.RSL, controller.RSR, controller.RSU, controller.RSD)
	var method_angle = vector.angle()
	joypad_right_stick_method_angle_label.text = str(method_angle)
	joypad_test_indicator_method.rotation = method_angle
	
	pass

func _aim():
	var attack_angle = controller.get_aim_angle(joypad_test_indicator)
	joypad_test_indicator.rotation = attack_angle

func get_x_val():
	return Input.get_axis(controller.RSL, controller.RSR)

func get_y_val():
	return Input.get_axis(controller.RSU, controller.RSD)

func get_normalized_vector_angle():
	return controller._get_stick_direction_vector(controller.RSL, controller.RSR, controller.RSU, controller.RSD).normalized().angle()
