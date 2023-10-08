extends KeyValueComponent

func _ready():
	set_value_text(get_current_git_revision())

func get_current_git_revision() -> String:
	var output = []
	var exit_code = OS.execute("git", ["rev-parse", "--short", "HEAD"], output)
	if exit_code == 0 and output.size() > 0:
		return output[0]
	else:
		printerr("Failed to get the git hash.")
		push_error("Failed to get git hash.")
		return ""
