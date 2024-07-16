extends ColorRect

onready var scene_tree: = get_tree()
onready var heart: = get_node("HBoxContainer/heart")
onready var sword: = get_node("HBoxContainer/sword")
onready var shield: = get_node("HBoxContainer/shield")


func _ready() -> void:
	heart.connect("option_chosen",self,"_on_option_chosen")
	sword.connect("option_chosen",self,"_on_option_chosen")
	shield.connect("option_chosen",self,"_on_option_chosen")

func _on_Chest_chest_opened() -> void:
	self.visible = true
	scene_tree.paused = true

func _on_option_chosen() -> void:
	scene_tree.paused= false
	queue_free()
