extends Node2D
class_name GunComponent

var controller: Controller
var joypad: Controller.Joypad
var mouse: Controller.Mouse

@export var projectile_speed := 100
@export var attack_interval := 30

@onready var projectile_start = $ProjectileStart
@onready var projectile_target = $ProjectileTarget
@onready var projectile_pool = $ProjectilePool

func attack():
	var bullet = projectile_pool.get_object()
	bullet.visible = true
	var facing_angle = _get_target_angle(projectile_start.global_position, projectile_target.global_position)
	bullet.update(projectile_speed, facing_angle)
	bullet.global_position = projectile_start.global_position
	Signals.emit_signal("projectile_shot")

func rotate_gun(is_facing_left: bool):
	if controller.is_mouse():
		look_at(get_global_mouse_position())
	
	if controller.is_joypad():
		_joypad_rotate_gun(is_facing_left)

func _get_target_angle(start_pos: Vector2, target_pos: Vector2) -> float:
	var dir_vector = target_pos - start_pos
	return atan2(dir_vector.y, dir_vector.x)

func _joypad_rotate_gun(is_facing_left: bool):
	var aim_direction_vector: Vector2 = joypad.get_right_stick_direction_vector()
	
	if aim_direction_vector != Vector2.ZERO:
		var rotation_angle = aim_direction_vector.angle()
		if is_facing_left:
			self.rotation = joypad.get_right_stick_rotation(self, rotation_angle, 0.5)
		else:
			self.rotation = joypad.get_right_stick_inverse_rotation(self, rotation_angle, 0.5)

func _init():
	controller = preload("res://Controller.gd").new()
	joypad = controller.Joypad.new()
	mouse = controller.Mouse.new()

func _unhandled_input(event):
	if event is InputEventJoypadMotion:
		controller.type = controller.JOYPAD

	if event is InputEventKey:
		controller.type = controller.MOUSE
