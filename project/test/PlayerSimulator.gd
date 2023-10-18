extends Node

const POSSIBLE_ACTIONS = ["ui_up", "ui_left", "ui_down", "ui_right"]

@export var STEP_DURATION := 2.0
@export var MOVE_SEQUENCE := POSSIBLE_ACTIONS
@export var MAX_ITERATIONS = 100

@onready var sequence_length = len(MOVE_SEQUENCE)

func _ready():
	release_all_actions()
	start_sequence(MOVE_SEQUENCE)

func release_all_actions():
	# Prevents an issue where switching from one test scene
	# to another causes an input to remain pressed
	for action in POSSIBLE_ACTIONS:
		release_action(action)

func start_sequence(moves: Array):
	var iteration = 0
	while iteration < MAX_ITERATIONS:
		var index = iteration % sequence_length
		var move = moves[index]
		press_action(move)
		await get_tree().create_timer(STEP_DURATION).timeout
		release_action(move)
		iteration += 1

func press_action(action):
	Input.action_press(action)

func release_action(action):
	Input.action_release(action)
