extends Control

@onready var cap_count_label = $HBoxContainer/CapCountLabel
@onready var commit_hash_label = $CommitHashContainer/CommitHashLabel

func _ready():
	Signals.connect("cap_count_updated", Callable(self, "_on_cap_count_updated"))
	commit_hash_label.text = get_current_git_revision()

func _on_cap_count_updated(count: int):
	cap_count_label.text = str(count)

func get_current_git_revision():
	var output = []
	var exit_code = OS.execute("git", ["rev-parse", "--short", "HEAD"], output)
	if exit_code == 0 and output.size() > 0:
		return output[0]
	else:
		printerr("Failed to get the git hash.")
		push_error("Failed to get git hash.")
		return ""
