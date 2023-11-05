extends Node
class_name XpTracker

@export var cap_count := 0

var current_level := 1
var until_next_level := calc_caps_required(current_level)

func collect():
	update_cap_count(1)

func update_cap_count(count: int):
	cap_count = cap_count + count
	Signals.xp_updated.emit(cap_count)
	if cap_count == until_next_level:
		level_up()

func calc_caps_required(level) -> int:
	return 5 * (pow(2, level) - 1)

func level_up():
	current_level += 1
	var level_cap_increase = calc_caps_required(current_level)
	until_next_level = level_cap_increase
	Signals.leveled_up.emit(current_level, cap_count, until_next_level)
