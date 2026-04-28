# ROLE: Star choice panel for picking new stars.
# OWNS: unchosen_starset, lock buttons.
# TALKS_TO: StarInfo, AudioPlayer, GameController.
# API: add_unchose_starset, return_chose_star, emit_refresh, close.
# INVARIANTS: StarInfoHolder exists in scene.
extends Panel
class_name StarChoices

const STAR_INFO := preload("res://scene/Autoload/StarInfo.tscn")

signal star_added(stardata: StarData)
signal refresh

@export var lock_button_1: TextureButton
@export var lock_button_2: TextureButton
@export var lock_button_3: TextureButton
@export var sound_effect: AudioStream

@onready var refresh_button: TextureButton = $VBoxContainer/refresh
@onready var close_button: Button = $VBoxContainer/close

var unchosen_starset: Array[StarData] = []

func _ready() -> void:
	close_button.pressed.connect(close)
	refresh_button.pressed.connect(emit_refresh)

func add_unchose_starset(star_set: Array[StarData]) -> void:
	for child in %StarInfoHolder.get_children():
		%StarInfoHolder.remove_child(child)
		child.queue_free()
	if lock_button_1.button_pressed and unchosen_starset.size() > 0:
		star_set[0] = unchosen_starset[0]
	if lock_button_2.button_pressed and unchosen_starset.size() > 1:
		star_set[1] = unchosen_starset[1]
	if lock_button_3.button_pressed and unchosen_starset.size() > 2:
		star_set[2] = unchosen_starset[2]
	unchosen_starset = star_set
	for i in range(star_set.size()):
		var stardata: StarData = star_set[i]
		var info_instance: StarInfo = STAR_INFO.instantiate() as StarInfo
		%StarInfoHolder.add_child(info_instance)
		info_instance.init(stardata)
		info_instance.visible = true
		info_instance.show_button()
		info_instance.chose.connect(return_chose_star.bind(i))
		AudioPlayer.audio_play(sound_effect)
		await get_tree().create_timer(0.3).timeout

func return_chose_star(index: int) -> void:
	visible = false
	star_added.emit(unchosen_starset[index])

func close() -> void:
	visible = false

func emit_refresh() -> void:
	refresh.emit()
