extends Control
class_name CountComponent

@export var count_name_node: Label
@export var count_amount_node: Label

func _ready():
    Signals.connect("count_updated", Callable(self, "_on_count_updated"))

func _on_count_updated(count: int):
    count_amount_node.text = str(count)