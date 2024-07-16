extends Button
signal pause_option_chosen
onready var scene_tree: = get_tree()

func _on_Continuar_button_up() -> void:
	scene_tree.paused = false
	emit_signal("pause_option_chosen")
	print("boton apretado")
