tool
extends Node2D

export var duration: float = 1
export var move_from: Vector2 = Vector2.ZERO
export var move_to: Vector2 = Vector2.ZERO

onready var line : Node2D =  get_node("Debug_line")
onready var base : Node2D =  get_node("Platform_base")
onready var tween : Tween =  get_node("Platform_base/Tween")

var direction_forward = false

func _ready() -> void:
	if !Engine.is_editor_hint():
		set_tween(move_from,move_to)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		update()
		
func _draw() -> void:
	if Engine.is_editor_hint():
		if line:
			draw_line(line.position + move_from, line.position + move_to, Color.lime, 2)

func set_tween(from, to):
	tween.interpolate_property(base, "position", from, to, duration, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if direction_forward:
		set_tween(move_from, move_to)
	else:
		set_tween(move_to, move_from)
	direction_forward = !direction_forward
