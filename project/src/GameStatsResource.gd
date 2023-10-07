extends Resource
class_name GameStatsResource

@export var cap_count := 0

func update_cap_count(count: int):
    cap_count = cap_count + count