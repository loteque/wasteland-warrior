extends Node2D

@export var spawn_group_size: int = 8
@export var mob_scene: PackedScene
@export var MAX_MOB_COUNT := 50

@onready var path: Path2D = $SpawnerPath2D
@onready var curve: Curve2D = path.curve
@onready var num_points = len(curve.get_baked_points())
@onready var mob_parent = get_node("/root/Main")
@onready var timer = $SpawnInterval

func _ready():
	spawn_mob_group()

func get_mob_count():
	return len(get_tree().get_nodes_in_group("Mobs"))

func spawn_mob_group():
	for i in spawn_group_size:
		spawn_mob()

func is_below_max_mob_count():
	return get_mob_count() < MAX_MOB_COUNT

func instance_mob(new_position: Vector2) -> Node2D:
	var mob = mob_scene.instantiate()
	mob.global_position = new_position
	return mob

func spawn_mob():
	var random_index = RandomUtils.rand.randi_range(0, num_points - 1)
	var spawn_position = path.curve.get_baked_points()[random_index] + path.global_position
	var mob_instance = instance_mob(spawn_position)
	mob_parent.add_child(mob_instance)

func move_to_player():
	var player_node = get_tree().get_nodes_in_group("player")[0]
	global_position = player_node.global_position

func _on_SpawnInterval_timeout():
	if is_below_max_mob_count():
		move_to_player()
		spawn_mob_group()
