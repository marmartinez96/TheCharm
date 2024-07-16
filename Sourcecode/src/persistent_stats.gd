extends Node

signal hp_changed(hp)
signal hp_depleted
signal xp_changed(xp)

const UP = Vector2.UP

var dmg : int = 50
var blk : int = 0
var hp : int = 3 setget set_hp 
var xp: int = 0 setget set_xp
var player_has_key: bool = false
var player_escaped: bool = false
export var gravity: float = 2000.0



func set_hp(value: int)->void:
	var random = randi() % 101
	if random <= blk:
		hp = hp
	else:
		hp = value
	hp = clamp(hp,0,3)
	emit_signal("hp_changed", hp)
	if hp == 0:
		emit_signal("hp_depleted")
	
	print("señal mandada")

func set_xp(value: int) -> void:
	xp = value
	emit_signal("xp_changed")
	print("xp señal emitida")


func reload_scene() -> void:
	hp = 3
	dmg = 50
	get_tree().change_scene_to(load("res://src/UI/endscreen/Endscreen.tscn"))
	#get_tree().reload_current_scene()
