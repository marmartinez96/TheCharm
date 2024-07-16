extends ColorRect

onready var scene_tree: = get_tree()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		scene_tree.paused = !scene_tree.paused
		visible = !visible

func _on_Continuar_pause_option_chosen() -> void:
	visible = false


func _on_Menu_principal_button_up() -> void:
	scene_tree.paused = false
	PersistentStats.reload_scene()
