extends Node2D

@export var speed := 100
@export var angle := 0
@export var damage := 1
@export var penetration_max := 2

@export var on_screen_notifier: VisibleOnScreenNotifier2D
@onready var collision_shape = $CollisionShape2D

var penetration_count = 0

var velocity = Vector2(speed, 0).rotated(angle)

func _physics_process(delta):
	if not visible:
		return
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
	self.visible = false
	collision_shape.disabled = true
	
func _on_Projectile_area_entered(area):
	var body = area.get_parent()
	if area.is_in_group("Mobs"):
		if Interface.is_implemented(body, Interface.Damageable):
			on_hit_enemy()

func _on_on_screen_notifier_screen_exited():
	die()

func _on_on_screen_notifier_screen_entered():
	collision_shape.disabled = false
