extends TextureRect
export var packed_scene : PackedScene
onready var current_scene: = get_tree()
onready var animation = get_node("AnimationPlayer")

func start_game() -> void:
	PersistentStats.xp = 0
	current_scene.change_scene_to(packed_scene)
func _on_Empezar_starting_game() -> void:
	Music.play_music()
	animation.play("fade_out")
