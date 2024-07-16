extends TextureRect
export var packed_scene : PackedScene
export var packed_scene2 : PackedScene
onready var current_scene: = get_tree()
onready var animation = get_node("AnimationPlayer")
onready var died_label = get_node("Died label")

func _ready() -> void:
	if PersistentStats.player_escaped:
		died_label.bbcode_text = "Has Escapado"
	else:
		died_label.bbcode_text = "Has Muerto"

func start_game() -> void:
	PersistentStats.xp = 0
	current_scene.change_scene_to(packed_scene)

func _on_Reiniciar_starting_game() -> void:
	animation.play("fade_out")

func _on_Salir_button_up() -> void:
	current_scene.quit()

func _on_main_Menu_button_up() -> void:
	current_scene.change_scene_to(packed_scene2)
