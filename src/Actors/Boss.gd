extends KinematicBody2D
onready var stats := PersistentStats
onready var animation := get_node("AnimationPlayer")
onready var hitbox: = get_node("Hitbox_special")
onready var hitbox_far: = get_node("Hitbox_special_far")
onready var hitbox_melee: = get_node("Hitbox_melee")
onready var special_animation: = get_node("Hitbox_special/AnimationPlayer")
onready var special_animation_far: = get_node("Hitbox_special_far/AnimationPlayer")
onready var mid_sprite: = get_node("Hitbox_special/special_mid")
onready var far_sprite: = get_node("Hitbox_special_far/special_far")
export var speed : Vector2
export var xp_yield := 125
onready var half_speed: = speed/2
var reached_limit: bool = false
var is_player_close: bool = false
var is_player_mid: bool = false
var is_player_far: bool = false
var health: = 250.0
var velocity: Vector2 = Vector2.ZERO
var idle_count : = 0

func _ready() -> void:
	animation.play("idle")
	stats.player_has_key=false

func _physics_process(delta: float) -> void:
	if not reached_limit:
		velocity.x = -speed.x 
		move_and_slide(velocity,stats.UP)
	else:
		return
	
	if idle_count > 3:
		attack()
	
	if health <1:
		animation.play("death")

func attack() -> void:
	reached_limit = true
	if !is_player_close and !is_player_mid and !is_player_far:
		enable_movement()
		return
	if is_player_far or is_player_mid:
		animation.play("special")
	elif is_player_close:
		animation.play("attack")

func enable_movement() -> void:
	reached_limit = false

func start_idle() -> void:
	animation.play("idle")

func add_idle_count() -> void:
	idle_count += 1

func reset_idle_count() -> void:
	idle_count = 0

func hit() -> void:
	hitbox.monitoring = true

func end_hit() -> void:
	hitbox.monitoring = false
	
func far_hit() -> void:
	hitbox_far.monitoring = true

func far_end_hit() -> void:
	hitbox_far.monitoring = false

func melee_hit() -> void:
	hitbox_melee.monitoring = true

func melee_end_hit() -> void:
	hitbox_melee.monitoring = false

func start_special() -> void:
	if is_player_mid:
		special_animation.play("special_mid")
	elif is_player_far:
		special_animation_far.play("special_far")

func special_mid_switch() -> void:
	mid_sprite.visible = !mid_sprite.visible

func special_far_switch() -> void:
	far_sprite.visible = !far_sprite.visible

func die() -> void:
	stats.player_escaped= true
	stats.xp += xp_yield
	queue_free()

func _on_PlayerDetector_body_entered(body: Node) -> void:
	is_player_close = true

func _on_PlayerDetector_body_exited(body: Node) -> void:
	is_player_close = false

func _on_PlayerDetector_mid_body_entered(body: Node) -> void:
	is_player_mid = true

func _on_PlayerDetector_mid_body_exited(body: Node) -> void:
	is_player_mid = false

func _on_PlayerDetector_far_body_entered(body: Node) -> void:
	is_player_far = true

func _on_PlayerDetector_far_body_exited(body: Node) -> void:
	is_player_far = false

func _on_Hitbox_special_body_entered(body: Node) -> void:
	stats.hp -= 1

func _on_Hitbox_body_entered(body: Node) -> void:
	stats.hp -= 1

func _on_stop_moving_body_entered(body: Node) -> void:
	speed = -speed
