# ROLE: Score controller for per-round scoring and progression.
# OWNS: round_score, total_score, target_score_list, target_score, round_index.
# TALKS_TO: StarPanel, AudioPlayer, UI score labels, ScoreCalculator, StarBalance.
# API: count_score, give_coin, debug_advance_round.
# INVARIANTS: star_panel assigned before scoring.
extends Node
class_name ScoreController

signal count_finished
signal score_updated(total_score: int, round_score: int)
signal round_changed(round_index: int, target_score: int)

@export var star_panel: StarPanel
@export var current_score_ui: RichTextLabel
@export var target_score_ui: Label
@export var round_score_ui: Label
@export var balance: StarBalance

const COUNT_SOUND := preload("res://sound/计分音效.sfxr")
const COIN_SCENE := preload("res://scene/铜钱body.tscn")

@export var interactable_object: CanvasLayer

var money_number: int = 0
var round_score: int = 0
var total_score: int = 0

var target_score_list := [50, 120, 250, 480, 700, 1000]
var round_index: int = 0
var target_score: int = target_score_list[0]
var score_calculator := ScoreCalculator.new()
var is_counting: bool = false
var _round_score_tween: Tween
var _round_score_value: int = 0

func _ready() -> void:
	if balance and balance.target_score_list.size() > 0:
		target_score_list = balance.target_score_list
		target_score = target_score_list[0]
	_update_target_score_ui()

func count_score() -> void:
	if is_counting:
		return
	if not star_panel:
		return
	is_counting = true
	round_score = 0
	_set_round_score_ui(0, 0.0)
	for palace_index in range(12):
		star_panel.hightlight_starpanel(palace_index)
		var palace: PalaceContainer = star_panel.find_palace(palace_index)
		if not palace:
			continue
		for star_icon: StarIcon in palace.get_stars():
			var star_instance := star_icon.star_instance
			var score_value := score_calculator.score_star(star_instance)
			star_icon.count_score_dynamic_effect(score_value)
			round_score += score_value
			
			if AudioPlayer.audio_player:
				AudioPlayer.audio_player.pitch_scale = 1.0 + (float(round_score) * 0.05)
			AudioPlayer.audio_play(COUNT_SOUND)
			await get_tree().create_timer(0.5).timeout
			_set_round_score_ui(round_score, 0.25)
		star_panel.normal_starpanel()
	if AudioPlayer.audio_player:
		AudioPlayer.audio_player.pitch_scale = 1.0
	await get_tree().create_timer(1.0).timeout
	var round_total := round_score
	await _tween_round_score_to_zero()
	total_score += round_total
	_update_score_ui()
	score_updated.emit(total_score, round_total)
	_evaluate_round_result()
	count_finished.emit()
	is_counting = false

func _update_score_ui() -> void:
	if current_score_ui:
		current_score_ui.text = str(total_score)
	_update_target_score_ui()

func _update_target_score_ui() -> void:
	if target_score_ui:
		target_score_ui.text = str(target_score)

func _evaluate_round_result() -> void:
	if round_index >= target_score_list.size():
		return
	if round_score >= target_score:
		round_index = min(round_index + 1, target_score_list.size() - 1)
		target_score = target_score_list[round_index]
		round_changed.emit(round_index, target_score)

func debug_advance_round() -> void:
	round_index = min(round_index + 1, target_score_list.size() - 1)
	target_score = target_score_list[round_index]
	_update_target_score_ui()
	round_changed.emit(round_index, target_score)

func give_coin(coin_number: int) -> void:
	if not interactable_object:
		return
	for i in range(coin_number):
		var coin = COIN_SCENE.instantiate()
		interactable_object.add_child(coin)
		var x_init_range = randi_range(-50, -80)
		var y_init_range = randi_range(get_viewport().size[1] * 0.35, get_viewport().size[1] * 0.65)
		coin.position = Vector2(x_init_range, y_init_range)
		var x_target_range = randi_range(100, 300)
		var y_target_range = randi_range(get_viewport().size[1] * 0.35, get_viewport().size[1] * 0.65)
		var target_position = Vector2(x_target_range, y_target_range)
		var target_rotation = randi_range(360, 720)
		var tween_coin = get_tree().create_tween()
		tween_coin.tween_property(coin, "position", target_position, 0.3).set_trans(Tween.TRANS_QUAD)
		tween_coin.tween_property(coin, "rotation", target_rotation, 0.3)
		coin.drop()
		await get_tree().create_timer(0.3).timeout

func _set_round_score_ui(value: int, duration: float) -> void:
	if not round_score_ui:
		return
	var from_value := _round_score_value
	_round_score_value = value
	if duration <= 0.0:
		round_score_ui.text = str(value)
		return
	_round_score_tween = _animate_number(round_score_ui, from_value, value, duration, _round_score_tween)

func _tween_round_score_to_zero() -> void:
	if not round_score_ui:
		return
	_round_score_tween = _animate_number(round_score_ui, _round_score_value, 0, 0.6, _round_score_tween)
	_round_score_value = 0
	await _round_score_tween.finished

func _animate_number(label: Label, from_value: int, to_value: int, duration: float, active_tween: Tween) -> Tween:
	if active_tween and active_tween.is_running():
		active_tween.kill()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_method(func(v: float) -> void:
		label.text = str(int(round(v))), float(from_value), float(to_value), duration)
	return tween
