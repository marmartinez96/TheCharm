extends Area2D

func _on_Pitbox_body_entered(body: Node) -> void:
	PersistentStats.hp -= 1
	PersistentStats.reload_scene() if PersistentStats.hp == 0 else body.set_position(body.last_checkpoint)
