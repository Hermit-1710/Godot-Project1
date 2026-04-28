# ROLE: UI panel animation manager for round flow.
# OWNS: fold states and target positions for panels.
# TALKS_TO: GameButton, UI panels (chessboard/count/guide/bag).
# API: PlayRoundStartTween, round_end_dynamic_effect, open_guidebook.
# INVARIANTS: exported UI nodes are assigned in scene.
extends Node
class_name UI_Manager

@export var chessboard: PanelContainer
@export var count_ui: PanelContainer
@export var guidebook: Control
@export var bag: PanelContainer

@export var fold_button: GameButton
@export var unfold_button: GameButton
@export var guide_button: GameButton

var panel_is_folded: bool = false
var star_panel_unfold_position: Vector2
var star_panel_fold_position: Vector2

var count_ui_is_folded: bool = false
var count_ui_unfold_position: Vector2
var count_ui_fold_position: Vector2

var guidebook_is_folded: bool = false
var guidebook_unfold_position: Vector2
var guidebook_fold_position: Vector2

var bag_is_folded: bool = false
var bag_unfold_position: Vector2
var bag_fold_position: Vector2

var screen_center: Vector2 = Vector2(800, 450)

func _ready() -> void:
	if fold_button:
		fold_button.pressed.connect(round_end_dynamic_effect)
	if unfold_button:
		unfold_button.pressed.connect(PlayRoundStartTween)
	if guide_button:
		guide_button.pressed.connect(open_guidebook)

	if chessboard:
		var y_movement = chessboard.size.y * 1.1
		star_panel_unfold_position = chessboard.position
		star_panel_fold_position = chessboard.position - Vector2(0, y_movement)

	if count_ui:
		var x_movement = count_ui.size.x - 50
		count_ui_unfold_position = count_ui.position
		count_ui_fold_position = count_ui.position - Vector2(x_movement, 0)

	if guidebook:
		var guidebook_x_movement = screen_center.x
		guidebook_fold_position = guidebook.position
		guidebook_unfold_position = guidebook.position - Vector2(guidebook_x_movement, 0)

	if bag:
		var bag_y_movement = 600
		bag_fold_position = bag.position
		bag_unfold_position = bag.position - Vector2(0, bag_y_movement)

func PlayRoundStartTween() -> void:
	if guidebook and guidebook.position != guidebook_fold_position:
		var tween = get_tree().create_tween()
		guidebook_fold_movement(tween)
		await get_tree().create_timer(0.4).timeout
	var tween_star = get_tree().create_tween()
	star_panel_unfold_movement(tween_star)
	await get_tree().create_timer(0.4).timeout
	count_ui_unfold_movement()

func round_end_dynamic_effect() -> void:
	star_panel_fold_movement()
	await get_tree().create_timer(0.4).timeout
	count_ui_fold_movement()

func open_guidebook() -> void:
	if not panel_is_folded:
		star_panel_fold_movement()
		await get_tree().create_timer(0.4).timeout
	guidebook_unfold_movement()

func guidebook_fold_movement(tween: Tween, time: float = 0.5) -> void:
	if not guidebook:
		return
	guidebook_is_folded = true
	tween.tween_property(guidebook, "position", guidebook_fold_position, time).set_trans(Tween.TRANS_BACK)

func guidebook_unfold_movement() -> void:
	if not guidebook:
		return
	guidebook_is_folded = false
	var tween = get_tree().create_tween()
	tween.tween_property(guidebook, "position", guidebook_unfold_position, 0.5).set_trans(Tween.TRANS_BACK)

func star_panel_fold_movement() -> void:
	if not chessboard:
		return
	panel_is_folded = true
	var tween_star = get_tree().create_tween()
	tween_star.tween_property(chessboard, "position", star_panel_fold_position, 0.8).set_trans(Tween.TRANS_BACK)

func star_panel_unfold_movement(_tween: Tween, time: float = 0.5) -> void:
	if not chessboard:
		return
	panel_is_folded = false
	var tween_star = get_tree().create_tween()
	tween_star.tween_property(chessboard, "position", star_panel_unfold_position, time).set_trans(Tween.TRANS_BACK)

func count_ui_fold_movement() -> void:
	if not count_ui:
		return
	count_ui_is_folded = true
	var tween_count = get_tree().create_tween()
	tween_count.tween_property(count_ui, "position", count_ui_fold_position, 0.5).set_trans(Tween.TRANS_BACK)

func count_ui_unfold_movement() -> void:
	if not count_ui:
		return
	count_ui_is_folded = false
	var tween_count = get_tree().create_tween()
	tween_count.tween_property(count_ui, "position", count_ui_unfold_position, 0.5).set_trans(Tween.TRANS_BACK)

func bag_fold_movement() -> void:
	if not bag:
		return
	bag_is_folded = true
	var tween_bag = get_tree().create_tween()
	tween_bag.tween_property(bag, "position", bag_fold_position, 0.5).set_trans(Tween.TRANS_BACK)

func bag_unfold_movement() -> void:
	if not bag:
		return
	bag_is_folded = false
	var tween_bag = get_tree().create_tween()
	tween_bag.tween_property(bag, "position", bag_unfold_position, 0.5).set_trans(Tween.TRANS_BACK)
