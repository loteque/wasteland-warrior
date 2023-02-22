extends Node2D

export var speed := 100
export var angle := 0
export var damage := 1
export var penetration_max := 2

var penetration_count = 0

var velocity = Vector2(speed, 0).rotated(angle)

func _physics_process(delta):
	transform.origin += velocity * delta

func update(speed: float = self.speed, angle: float = self.angle):
	self.speed = speed
	self.angle = angle
	self.velocity = Vector2(speed, 0).rotated(angle)

func on_hit_enemy():
	penetration_count += 1
	if penetration_count >= penetration_max:
		die()
	
func die():
	queue_free()

func _on_Projectile_area_entered(area):
	if area.is_in_group("Mobs"):
		on_hit_enemy()
