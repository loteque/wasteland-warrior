extends Node2D
class_name GunComponent

@export var projectile_speed := 100
@export var attack_interval := 30

@onready var projectile_start = $ProjectileStart
@onready var projectile_target = $ProjectileTarget
@onready var projectile_pool = $ProjectilePool

enum Controller {JOYPAD, MOUSE}
var controller: Controller

func get_target_angle(start_pos: Vector2, target_pos: Vector2) -> float:
	var dir_vector = target_pos - start_pos
	return atan2(dir_vector.y, dir_vector.x)

func attack():
	var bullet = projectile_pool.get_object()
	bullet.visible = true
	var facing_angle = get_target_angle(projectile_start.global_position, projectile_target.global_position)
	bullet.update(projectile_speed, facing_angle)
	bullet.global_position = projectile_start.global_position
	Signals.emit_signal("projectile_shot")

func rotate_gun(is_facing_left: bool):
	var aim_direction_vector: Vector2 = _get_stick_direction_vector()
	
	if aim_direction_vector != Vector2.ZERO:
		var rotation_angle = aim_direction_vector.angle()
		if is_facing_left:
			_rotate_gun_left(rotation_angle)
		else:
			_rotate_gun_right(rotation_angle)

func _is_mouse() -> bool:
	return controller == Controller.MOUSE

func _is_joypad() -> bool:
	return controller == Controller.JOYPAD

func _get_stick_direction_vector() -> Vector2:
	return Vector2(Input.get_axis("aim_left", "aim_right"), Input.get_axis("aim_up", "aim_down"))

func _rotate_gun_right(rotation_angle):
		if _is_joypad():
			self.rotation = lerp_angle(self.rotation, rotation_angle, 0.5)
		if _is_mouse():
			look_at(get_global_mouse_position())
		return rotation

func _rotate_gun_left(rotation_angle):
		if _is_joypad():
			self.rotation = lerp_angle(self.rotation, -(rotation_angle + PI), 0.5)
		if _is_mouse():
			look_at(get_global_mouse_position())
		return rotation

func _unhandled_input(event):
	if event is InputEventJoypadMotion:
		controller = Controller.JOYPAD

	if event is InputEventMouse:
		controller = Controller.MOUSE
