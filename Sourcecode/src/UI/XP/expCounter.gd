extends NinePatchRect
onready var label: = get_node("Label")

func _ready() -> void:
	label.text = "%s" %PersistentStats.xp
	PersistentStats.connect("xp_changed", self, "update_xp")

func update_xp()->void:
	label.text = "%s" %PersistentStats.xp

