tool
extends Object
class_name RandomUtils

var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

static func generate_random_binary() -> int:
	return randi() % 2

static func generate_random_sign():
	if generate_random_binary():
		return 1
	return -1
