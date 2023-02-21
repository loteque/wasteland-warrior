extends KinematicBody2D
class_name Mob

export var speed = 20
export var MIN_CHASE_DISTANCE_PIXELS = 1

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
