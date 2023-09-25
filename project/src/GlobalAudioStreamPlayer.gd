extends Node

var current_channel_index = 0

@export var audios := {
	"shoot": preload("res://assets/audio/shoot.wav"),
	"hit": preload("res://assets/audio/hit.wav")
}

@onready var channels = get_children()
@onready var channel_count = channels.size()

func _ready():
	Signals.connect("sound_fx", Callable(self, "play_by_name"))
	Signals.connect("projectile_shot", Callable(self, "_on_sfx_event").bind("shoot"))
	Signals.connect("player_hit", Callable(self, "_on_sfx_event").bind("hit"))
	Signals.connect("mob_hit", Callable(self, "_on_sfx_event").bind("hit"))

func _on_sfx_event(name: String):
	play_by_name(name)

func play_by_name(name: String):
	var stream = audios[name]
	var channel: AudioStreamPlayer = get_next_channel()
	channel.stream = stream
	channel.play()

func get_next_channel() -> AudioStreamPlayer:
	current_channel_index += 1
	current_channel_index = current_channel_index % channel_count
	return channels[current_channel_index]
