extends Area2D
signal chest_opened
onready var animation_player: = get_node("AnimationPlayer")

var is_character_close: bool
var is_opened: bool

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_character_close and not is_opened:
		animation_player.play("open")
		is_opened= true
		yield(animation_player,"animation_finished")
		emit_signal("chest_opened")

func _monitoring_off() -> void:
	monitoring = false
func _monitoring_on() -> void:
	monitoring = true


func _on_Chest_body_entered(body: Node) -> void:
		is_character_close = true

func _on_Chest_body_exited(body: Node) -> void:
		is_character_close = false

func _on_Dialog_text_finished() -> void:
	if visible == false:
		visible = true
		animation_player.play("spawn")
		yield(animation_player,"animation_finished")
