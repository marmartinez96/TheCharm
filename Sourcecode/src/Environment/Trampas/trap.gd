extends Area2D

func _on_trampa_body_entered(body: KinematicBody2D) -> void:
	PersistentStats.hp -= 1
	if PersistentStats.hp > 0:
		 body.set_position(body.last_checkpoint)

