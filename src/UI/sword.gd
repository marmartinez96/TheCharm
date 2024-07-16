extends Button

signal option_chosen

func _on_sword_button_up() -> void:
		PersistentStats.dmg += 25
		emit_signal("option_chosen")
