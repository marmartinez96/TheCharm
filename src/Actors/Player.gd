extends KinematicBody2D

onready var stats = PersistentStats
onready var sprite = get_node("Sprite")
onready var hitbox = get_node("AttackBox")
onready var animation =  get_node("AnimationPlayer")
onready var is_attacking : bool = animation.current_animation == "attack"
onready var camara = get_node("Camera2D")
onready var collisionbox: = get_node("CollisionShape2D")
onready var last_checkpoint: Vector2 = position

export var speed: = Vector2(150,500)
var velocity: Vector2 
var is_frozen: bool = false

func _ready() -> void:
	last_checkpoint = position
	PersistentStats.connect("hp_depleted",self,"_on_hp_depleted")

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0
	var direction = get_direction() if not is_frozen else Vector2.ZERO
	velocity = calculate_move_velocity(velocity,direction,speed,is_jump_interrupted)
	velocity = move_and_slide(velocity,stats.UP) 
	if is_frozen:
		velocity.y == 0
	if direction.x < 0:
		sprite.scale.x = -1
		hitbox.scale.x = -1
		collisionbox.scale.x = -1
	if direction.x > 0:
		sprite.scale.x = 1
		hitbox.scale.x = 1
		collisionbox.scale.x = 1
	if velocity.x == 0 and is_on_floor() and not is_frozen:
		animation.play("idle")
	if velocity.x != 0 and is_on_floor():
		animation.play("run")
	if velocity.y < 0:
		animation.play("jump")
	if velocity.y > 0 and not is_on_floor() and not is_frozen:
		animation.play("fall")
	if Input.is_action_just_pressed("attack") and not is_frozen and is_on_floor():
		attack()
	
func get_direction() -> Vector2:
	var out: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
	-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	return out

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += stats.gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0
	return out

func attack() -> void:
	is_frozen= true
	animation.play("attack")
	yield(animation, "animation_finished")	
	is_frozen= false

func die() -> void:
	is_frozen = true
	animation.play("death")
	yield(animation, "animation_finished")
	is_frozen = false
	stats.reload_scene()
	

func _on_AttackBox_body_entered(body: Node) -> void:
	body.health -= stats.dmg
	print("Le pegue")

func _on_hp_depleted() -> void:
	die() 

func hit_player():
	hitbox.monitoring = true
	
func end_of_hit_player():
	hitbox.monitoring = false
	
func start_idle_player():
	animation.play("idle")


