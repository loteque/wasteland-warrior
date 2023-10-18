extends Node2D
class_name GunComponent

@export var projectile_speed := 100
@export var attack_interval := 30

@onready var projectile_start = $ProjectileStart
@onready var projectile_target = $ProjectileTarget
@onready var projectile_pool = $ProjectilePool

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

func _get_rotation_angle():
	var direction_vector = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	var rotation_angle = direction_vector.angle()
	return rotation_angle

func rotate_gun_right():
		self.rotation = _get_rotation_angle()
		look_at(get_global_mouse_position())

func rotate_gun_left():
		self.rotation = -_get_rotation_angle() + PI
		look_at(get_global_mouse_position())
