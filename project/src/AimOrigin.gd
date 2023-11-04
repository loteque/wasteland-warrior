class_name AimOrigin
extends Marker2D
## Used as a non-scaling, non-rotating point which follows the player
## and can be used make transform calculations unaffected by player transforms.

@export var update_period := 15

@onready var target: Node2D = get_parent()
@onready top_level = true

func follow(follow_target: Node2D):
	transform.origin = follow_target.transform.origin

func _ready():
	top_level = true # Ensures it's not affected by parent scaling

func _physics_process(_delta: float) -> void:
	follow(target)