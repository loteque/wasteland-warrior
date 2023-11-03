class_name AimOrigin
extends Marker2D

# Used as a non-scaling, non-rotating point which follows the player
# and can be used make transform calculations unaffected by player transforms.

@export var update_period := 15

@onready var target: Node2D = get_parent()

func _ready():
	top_level = true # Ensures it's not affected by parent scaling

func _physics_process(delta: float) -> void:
	follow(target)

func follow(target: Node2D):
	transform.origin = target.transform.origin
