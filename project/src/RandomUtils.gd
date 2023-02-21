extends Object
class_name RandomUtils

var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

func generate_random_binary() -> int:
	return rand.randi() % 2

func generate_random_sign():
	if generate_random_binary():
		return 1
	return -1
