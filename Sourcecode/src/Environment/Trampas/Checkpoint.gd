extends Area2D

func _on_czek_point_body_entered(body: Node) -> void:
	body.last_checkpoint = body.get_position()
	queue_free()
