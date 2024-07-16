extends Node

onready var music_player = get_node("AudioStreamPlayer")
onready var tween = get_node("Tween")
onready var music = load("res://src/Music/music.mp3")

func play_music() -> void:
	music_player.play()
	tween.interpolate_property(music_player,"volume_db", -30, -15, 1, tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
