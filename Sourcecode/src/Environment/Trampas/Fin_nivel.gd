extends Area2D
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var next_scene: PackedScene

func _get_configuration_warning() -> String:
	return"The next_scene property cant be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("Fade")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(next_scene)

func _on_Fin_nivel_body_entered(body: Node) -> void:
	teleport()
