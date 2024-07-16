extends Area2D
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_Fin_nivel_body_entered(body: Node) -> void:
	PersistentStats.reload_scene()
