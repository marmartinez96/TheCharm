extends Control
onready var fade:= get_node("Fade")

func delete_fade_in() -> void:
	fade.queue_free()
