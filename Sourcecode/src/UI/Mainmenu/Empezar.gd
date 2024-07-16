extends Button
signal starting_game

func _on_Empezar_button_up() -> void:
	emit_signal("starting_game")
