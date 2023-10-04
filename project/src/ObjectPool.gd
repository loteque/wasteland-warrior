extends Node
class_name ObjectPool

@export var pool_size := 20
@export var object_scene: PackedScene
var object_pool = []
var next_object_index = 0

func _ready():
	for i in range(pool_size):
		var object = object_scene.instantiate()
		add_child(object)
		object.visible = false
		object_pool.append(object)

func get_object():
	var object = object_pool[next_object_index]
	next_object_index = (next_object_index + 1) % pool_size
	return object

func reset_object(object):
	object.visible = false
