extends Button

signal option_chosen

func _on_heart_button_up() -> void:
	PersistentStats.hp = 3
	emit_signal("option_chosen")
