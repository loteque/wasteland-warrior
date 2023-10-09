extends VBoxContainer

@onready var retry_button = %RetryButton

func _on_visibility_changed():
	if visible:
		retry_button.grab_focus()
