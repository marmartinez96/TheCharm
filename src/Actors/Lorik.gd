extends Area2D

onready var current_tree: = get_tree()
onready var animation: = get_node("AnimationPlayer")
onready var tween : = get_node("Tween")
onready var hint: = get_node("HBoxContainer/TextureRect")
onready var hint_player: = get_node("HBoxContainer/AnimationPlayer")
onready var dialog: = get_node("CanvasLayer/Dialog")

var is_player_close: = false
var is_hint_shown : = false
var hint_spent : = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact")and not hint_spent:
		interact()
	else:
		return

func start_idle() -> void:
	animation.play("idle")

func _on_Lorik_body_entered(body: Node) -> void:
	is_player_close = true
	hint.visible
	if not is_hint_shown: 
		hint_player.play("show_hint")
		is_hint_shown = true

func _on_Lorik_body_exited(body: Node) -> void:
	is_player_close = false

func interact() -> void:
	hint.visible = false
	hint_spent = true
	animation.play("talking")
	dialog.visible = true

func _on_despawn_body_entered(body: Node) -> void:
	visible = false


func _on_Dialog_text_finished() -> void:
	start_idle()


func _on_Llave_body_entered(body: Node) -> void:
	PersistentStats.player_has_key = true
