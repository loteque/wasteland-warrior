extends Node2D
class_name GunComponent

@export var projectile_speed := 100
@export var attack_interval := 30

@onready var projectile_start = $ProjectileStart
@onready var projectile_target = $ProjectileTarget
@onready var projectile_pool = $ProjectilePool

var player: CharacterBody2D

#this is defined in two places playercontroller and guncomponent
func rotate_180(radians: float):
	return radians + PI

func attack():
	var bullet = projectile_pool.get_object()
	bullet.visible = true
	var facing_angle = projectile_start.get_angle_to(projectile_target.global_position)
	if player and player.is_facing_left():
		facing_angle = rotate_180(facing_angle)
	
	bullet.update(projectile_speed, facing_angle)
	bullet.global_position = projectile_start.global_position
	Signals.emit_signal("projectile_shot")
