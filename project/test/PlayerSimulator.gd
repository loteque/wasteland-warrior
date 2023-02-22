extends Node

const POSSIBLE_ACTIONS = ["ui_up", "ui_left", "ui_down", "ui_right"]

export var STEP_DURATION := 2.0
export var MOVE_SEQUENCE := POSSIBLE_ACTIONS
export var MAX_ITERATIONS = 100

var sequence_length = len(MOVE_SEQUENCE)

func _ready():
	start_sequence(POSSIBLE_ACTIONS)

func start_sequence(moves: Array):
	var iteration = 0
	while iteration < MAX_ITERATIONS:
		var index = iteration % sequence_length
		var move = moves[index]
		press_action(move)
		yield(get_tree().create_timer(STEP_DURATION), "timeout")
		release_action(move)
		iteration += 1

func press_action(action):
	Input.action_press(action)

func release_action(action):
	Input.action_release(action)
