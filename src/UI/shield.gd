extends Button

signal option_chosen

func _on_shield_button_up() -> void:
		PersistentStats.blk += 10
		emit_signal("option_chosen")
