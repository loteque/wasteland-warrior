extends Node2D

export var speed := 100
export var angle := 0

var velocity = Vector2(speed, 0).rotated(angle)

func _physics_process(delta):
	transform.origin += velocity * delta

func update(speed: float = self.speed, angle: float = self.angle):
	self.speed = speed
	self.angle = angle
	self.velocity = Vector2(speed, 0).rotated(angle)
