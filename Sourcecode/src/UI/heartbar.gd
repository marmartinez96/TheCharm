extends HBoxContainer

onready var heart1 := get_node("heart1")
onready var heart2 := get_node("heart2")
onready var heart3 := get_node("heart3")
onready var animation := get_node("AnimationPlayer")
onready var stats := PersistentStats

var heart1_lost: = false
var heart2_lost: = false
var heart3_lost: = false

func _ready() -> void:
	PersistentStats.connect("hp_changed", self, "on_hp_changed")
	update_hp()

func on_hp_changed(hp) -> void:
	if hp < 1 and not heart1_lost:
		animation.play("heart1_fade_out")
		yield(animation,"animation_finished")
		heart1_lost = true
	if hp > 1 and heart2_lost:
		animation.play("heart2_fade_in")
		yield(animation,"animation_finished")
		heart2_lost = false
	if hp < 2 and not heart2_lost:
		animation.play("heart2_fade_out")
		yield(animation,"animation_finished")
		heart2_lost = true
	if hp > 2 and heart3_lost:
		animation.play("heart3_fade_in")
		yield(animation,"animation_finished")
		heart3_lost = false
	if hp < 3 and not heart3_lost:
		animation.play("heart3_fade_out")
		yield(animation,"animation_finished")
		heart3_lost = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print(PersistentStats.hp)
		PersistentStats.hp -= 1
		print(PersistentStats.hp)
		print("dmg = ",PersistentStats.dmg)
		print("blk = ",PersistentStats.blk)
	if Input.is_action_just_pressed("debug 2"):
		print(PersistentStats.hp)
		PersistentStats.hp += 1
		print(PersistentStats.hp)
		PersistentStats.xp += 100
		print(PersistentStats.xp)
		
func update_hp() ->void:
	if stats.hp < 1 and not heart1_lost:
		animation.play("heart1_fade_out")
		yield(animation,"animation_finished")
		heart1_lost = true
	if stats.hp > 1 and heart2_lost:
		animation.play("heart2_fade_in")
		yield(animation,"animation_finished")
		heart2_lost = false
	if stats.hp < 2 and not heart2_lost:
		animation.play("heart2_fade_out")
		yield(animation,"animation_finished")
		heart2_lost = true
	if stats.hp > 2 and heart3_lost:
		animation.play("heart3_fade_in")
		yield(animation,"animation_finished")
		heart3_lost = false
	if stats.hp < 3 and not heart3_lost:
		animation.play("heart3_fade_out")
		yield(animation,"animation_finished")
		heart3_lost = true
