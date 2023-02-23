extends KinematicBody2D

export var speed = 20
export var MIN_CHASE_DISTANCE_PIXELS = 1
export var death_health_value := 0
var damage := 1
var health := 2


onready var target = get_tree().get_nodes_in_group("player")[0]

func _ready():
	pass

func _init(target = target):
	self.target = target

func _physics_process(_delta):
	chase_target(target)

func chase_target(target: Node2D):
	var distance = target.global_position - global_position
	if distance.length() > MIN_CHASE_DISTANCE_PIXELS:
		var direction = distance.normalized()
		move_and_slide(direction * speed)

func die():
	queue_free()

func take_damage(value: float):
	health -= value
	if health <= death_health_value:
		die()

func _on_HurtBox_area_entered(area):
	if area.is_in_group("CanDamageMob"):
		take_damage(area.damage)
