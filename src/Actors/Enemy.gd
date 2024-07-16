extends KinematicBody2D

onready var animation: = get_node("AnimationPlayer")
onready var hray: = get_node("RayCast2D")
onready var vray: = get_node("RayCast2D2")
onready var atkdetector: = get_node("AttackDetector")
onready var enemydetector: = get_node("PlayerDetector")

export var speed: Vector2
export var xp_yield: int = 25
var velocity: Vector2
var is_moving_left: bool = true
var is_player_close: bool = false
var is_frozen: bool = false
var health: = 50

func _ready():
	animation.play("walk")
	
func _process(delta: float) -> void:
	if animation.current_animation == "attack" and is_player_close:
		return
	else:
		end_of_hit()
	velocity = move_character(velocity) if not is_frozen else Vector2.ZERO
	if velocity.x != 0:
		animation.play("walk")
	detect_turn_around()
	if is_player_close and not is_frozen:
		animation.play("attack")
	if health <= 0:
		death()

	
func move_character(velocity: Vector2) -> Vector2:
	velocity.x = -speed.x if is_moving_left else speed.x
	velocity.y += PersistentStats.gravity
	velocity = move_and_slide(velocity,PersistentStats.UP)
	return velocity

func detect_turn_around():
	if not vray.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		print("pozo detectado")
	elif hray.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		print("muro detectado")

func _on_PlayerDetector_body_entered(body: Node) -> void:
	is_player_close = true
	
func _on_AttackDetector_body_entered(body: Node) -> void:
	print("Pego")
	PersistentStats.hp -= 1
	if PersistentStats.hp == 0: return
	
func _on_PlayerDetector_body_exited(body: Node) -> void:
	is_player_close = false

func hit():
	atkdetector.monitoring = true

func end_of_hit():
	atkdetector.monitoring = false

func _remove_enemy() -> void:
	queue_free()
	
func _award_xp() -> void:
	PersistentStats.xp += xp_yield

func death() -> void:
	is_frozen=true
	animation.play("death")


