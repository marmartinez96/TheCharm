extends Control

signal text_finished
onready var current_tree: = get_tree()
onready var timer: = get_node("Timer")
onready var texto: = get_node("fondo/texto")
onready var nombre: = get_node("fondo/Nombre")
export var dialogpath = ""
export var text_speed : float = 0.06
var dialog = []
var phrase_num = 0
var is_finished = false
var is_exhausted = false
var is_visible = visible setget set_visible


func _ready() -> void:
	load_file()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_exhausted == false:
		current_tree.paused = true
		if is_finished:
			next_phrase()
		else:
			texto.visible_characters = len(texto.text)

func get_dialog() -> Array:
	var f = File.new()
	assert (f.file_exists(dialogpath), "file path does not exist")
	
	f.open(dialogpath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return[]
	
func next_phrase() -> void:
	if phrase_num >= len(dialog):
		print("text finished")
		emit_signal("text_finished")
		visible=false
		return
	is_finished = false
	texto.bbcode_text = dialog[phrase_num]["Text"]
	nombre.bbcode_text = dialog[phrase_num]["Name"]
	texto.visible_characters = 0
	while texto.visible_characters < len(texto.text):
		texto.visible_characters += 1
		timer.start()
		yield(timer,"timeout")
	is_finished = true
	print("phrase num before:", phrase_num)
	phrase_num += 1
	print("phrase num after:", phrase_num)
	return

func load_file() -> void:
	timer.wait_time = text_speed
	dialog = get_dialog()
	assert(dialog, "Dialog not found")
	phrase_num = 0
	next_phrase()

func _on_Dialog_text_finished() -> void:
	print("recibido")
	current_tree.paused= false
	is_exhausted = true
	load_file()
	
func set_visible(value) -> void:
		is_visible = value
		visible = is_visible
		if visible:
			load_file()
		else: 
			phrase_num = 0
