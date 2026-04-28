# ROLE: Main info panel for exam/round/score display.
# OWNS: labels for exam, round, total score, submit/modify counts.
# TALKS_TO: ScoreController, GameController, StarBalance.
# API: _on_round_changed, _on_score_updated, _on_submit_left_changed, _on_modify_left_changed.
# INVARIANTS: label nodes are assigned in scene.
extends PanelContainer
class_name GameInfoPanel

@export var score_controller: ScoreController
@export var game_controller: GameController
@export var balance: StarBalance
@export var exam_label: Label
@export var round_label: Label
@export var total_score_label: Label
@export var submit_left_label: Label
@export var modify_left_label: Label

var exam_names: Array[String] = ["县试", "府试", "院试", "乡试", "会试", "殿试"]

var _total_score_value: int = 0
var _submit_left_value: int = 0
var _modify_left_value: int = 0
var _initialized: bool = false

var _score_tween: Tween
var _submit_tween: Tween
var _modify_tween: Tween

func _ready() -> void:
	if balance and balance.exam_names.size() > 0:
		exam_names = balance.exam_names
	if score_controller:
		score_controller.score_updated.connect(_on_score_updated)
		score_controller.round_changed.connect(_on_round_changed)
		_refresh(score_controller.round_index, score_controller.total_score)
	if game_controller:
		game_controller.submit_left_changed.connect(_on_submit_left_changed)
		game_controller.modify_left_changed.connect(_on_modify_left_changed)
		_refresh_limits(game_controller.submit_left, game_controller.modify_left)
	_initialized = true

func _on_round_changed(new_round: int, _target_score: int) -> void:
	_refresh(new_round, score_controller.total_score)

func _on_score_updated(total_score: int, _round_score: int) -> void:
	_set_total_score(total_score)

func _on_submit_left_changed(value: int) -> void:
	_set_submit_left(value)

func _on_modify_left_changed(value: int) -> void:
	_set_modify_left(value)

func _refresh(round_index: int, total_score: int) -> void:
	if exam_label:
		var index: int = clampi(round_index, 0, exam_names.size() - 1)
		exam_label.text = exam_names[index]
	if round_label:
		round_label.text = "【第%d场】" % (round_index + 1)
	_set_total_score(total_score)

func _refresh_limits(submit_left: int, modify_left: int) -> void:
	_set_submit_left(submit_left)
	_set_modify_left(modify_left)

func _set_total_score(value: int) -> void:
	if not total_score_label:
		return
	var from_value := _total_score_value
	_total_score_value = value
	if not _initialized:
		total_score_label.text = str(value)
		return
	_score_tween = _animate_number(total_score_label, from_value, value, 1.0, _score_tween)

func _set_submit_left(value: int) -> void:
	if not submit_left_label:
		return
	var from_value := _submit_left_value
	_submit_left_value = value
	if not _initialized:
		submit_left_label.text = str(value)
		return
	_submit_tween = _animate_number(submit_left_label, from_value, value, 0.4, _submit_tween)

func _set_modify_left(value: int) -> void:
	if not modify_left_label:
		return
	var from_value := _modify_left_value
	_modify_left_value = value
	if not _initialized:
		modify_left_label.text = str(value)
		return
	_modify_tween = _animate_number(modify_left_label, from_value, value, 0.4, _modify_tween)

func _animate_number(label: Label, from_value: int, to_value: int, duration: float, active_tween: Tween) -> Tween:
	if active_tween and active_tween.is_running():
		active_tween.kill()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_method(func(v: float) -> void:
		label.text = str(int(round(v))), float(from_value), float(to_value), duration)
	return tween
