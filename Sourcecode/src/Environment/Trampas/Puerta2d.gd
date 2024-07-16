extends Area2D
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var next_scene: PackedScene
var damage :float
var hearts :float

var is_character_close: bool

func _on_body_entered(body: Node) -> void:
	is_character_close = true

func _on_Area2D_body_exited(body: Node) -> void:
	is_character_close = false

func _get_configuration_warning() -> String:
	return"The next_scene property cant be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("Fade")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(next_scene)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("interact") and is_character_close and PersistentStats.player_has_key:
		teleport()


