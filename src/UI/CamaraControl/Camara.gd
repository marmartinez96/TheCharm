extends Camera2D
export var target_path: NodePath
onready var tween = get_node("Tween")
var target

func _ready() -> void:
	target = get_node(target_path)
	if target: 
		position  = target.position
func _physics_process(delta: float) -> void:
	if ! target:
		return
	position = lerp(position,target.position,0.8)
	#if Input.is_action_just_pressed("up"):
	#	look_up()
	#	print("llego")

func look_up() -> void:
	var current_position = position
	tween.interpolate_property(self, "position", current_position, current_position+Vector2(0,-64),0.3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

