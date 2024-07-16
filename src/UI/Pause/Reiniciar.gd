extends Button
onready var current_scene = get_tree()

func _on_Reiniciar_button_up() -> void:
	current_scene.paused = false
	PersistentStats.xp = 0
	current_scene.reload_current_scene()
	
