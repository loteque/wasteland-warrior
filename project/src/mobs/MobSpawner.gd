extends Node2D
class_name MobSpawner

const RandomUtils = preload("res://src/RandomUtils.gd")

export var spawn_rate: float = 5.0
export var mob_scene: PackedScene
export var MAX_MOB_COUNT := 100

export var player_node_path = "/root/MobSpawnerTest/PlayerController"
var spawn_timer: Timer

func _ready():
	pass
#	spawn_timer.connect("timeout", self, "spawn_enemy")
#	add_child(spawn_timer)
#	spawn_timer.wait_time = 1 / spawn_rate
#	spawn_timer.start()
	

func get_mob_count():
	return len(get_tree().get_nodes_in_group("mobs"))

func _process(delta):
	if randf() < spawn_rate * delta and is_below_max_mob_count():
		spawn_mob()

func is_below_max_mob_count():
	return get_mob_count() < MAX_MOB_COUNT

func create_mob(position: Vector2) -> Mob:
	var mob = mob_scene.instance()
	mob.player_node_path = player_node_path
	mob.position = position
	return mob

func spawn_mob():
	var margin = 50
	var viewport_rect = get_viewport_rect()
	print(viewport_rect)
	var spawn_rect = Rect2(
		viewport_rect.position,
		viewport_rect.size + Vector2(margin * 2, margin * 2)
	)
	var spawn_position = Vector2(
		rand_range(spawn_rect.position.x, spawn_rect.end.x),
		rand_range(spawn_rect.position.y, spawn_rect.end.y)
	)
	
	spawn_position = get_random_spawn_location()

	var mob_instance = create_mob(spawn_position)
	add_child(mob_instance)

func calculate_random_position_outside_view():
	var MAX_SPAWN_DISTANCE = 50
	var viewport_rect = get_viewport_rect()
	var viewport_size = viewport_rect.size
	var half_screen_width = viewport_size.x / 2.0
	var half_screen_height = viewport_size.y / 2.0
	var max_x_spawn_distance = half_screen_width + MAX_SPAWN_DISTANCE
	var max_y_spawn_distance = half_screen_height + MAX_SPAWN_DISTANCE
	var x = get_random_x(half_screen_width, max_x_spawn_distance)
	var y = get_random_y(half_screen_height, max_y_spawn_distance)
	return Vector2(x, y)

func get_random_x(half_screen_width, max_x_spawn_distance) -> float:
	var x_distance = rand_range(half_screen_width, max_x_spawn_distance)
	var sign_mult = RandomUtils.generate_random_sign()
	return sign_mult * x_distance

func get_random_y(half_screen_height, max_y_spawn_distance) -> float:
	var y_distance = rand_range(half_screen_height, max_y_spawn_distance)
	var sign_mult = RandomUtils.generate_random_sign()
	return sign_mult * y_distance

func get_random_spawn_location():
	return calculate_random_position_outside_view()
