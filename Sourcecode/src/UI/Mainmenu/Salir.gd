extends Button
onready var current_scene: = get_tree()

func _on_Salir_button_up() -> void:
	current_scene.quit()
