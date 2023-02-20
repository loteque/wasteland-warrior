extends KinematicBody2D
class_name Mob

export var speed = 20
export var MIN_CHASE_DISTANCE_PIXELS = 1
export var player_node_path = "/root/MobTest/PlayerController"

onready var player = get_node(player_node_path)

func _physics_process(_delta):
	chase_target(player)

func chase_target(target: Node2D):
	var distance = target.global_position - global_position
	if distance.length() > MIN_CHASE_DISTANCE_PIXELS:
		var direction = distance.normalized()
		move_and_slide(direction * speed)
