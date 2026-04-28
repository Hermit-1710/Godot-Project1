# ROLE: Game controller for round flow, star inventory, distribution, and choice.
# OWNS: catalog, inventory, exam_level, luck, rarity_distribution, rng.
# TALKS_TO: UI_Manager, StarChoices, StarPanel, ScoreController, AudioPlayer, StarIcon, RarityPicker.
# API: start_round, submit_round, open_star_choice_ui, add_or_upgrade_star, pick_random_star, update_backpack_ui.
# INVARIANTS: catalog loaded before distribution; inventory stores StarInstance.
extends Node
class_name GameController

signal round_started
signal stars_distributed
signal round_scored
signal submit_left_changed(value: int)
signal modify_left_changed(value: int)

@export var ui_manager: UI_Manager
@export var star_choice_ui: StarChoices
@export var star_backpack: GridContainer
@export var start_round_button: Button
@export var submit_button: Button
@export var star_panel: StarPanel
@export var exam_name_ui: Label
@export var score_controller: ScoreController

const STARSET_PATH := "res://data/starset.tres"
const STAR_TEXT_NODE := preload("res://scene/starText/StarTextNode.tscn")
const ADD_SOUND := preload("res://sound/add.mp3")
const UPGRADE_SOUND := preload("res://sound/upgrade.sfxr")

var catalog: StarSet
var inventory: Array[StarInstance] = []
var rng := RandomNumberGenerator.new()

var exam_names: Array[String] = ["县试", "府试", "院试", "乡试", "会试", "殿试"]
var exam_level: int = 0:
	set(value):
		exam_level = clamp(value, 0, exam_names.size() - 1)
		if exam_name_ui:
			exam_name_ui.text = exam_names[exam_level]

var luck: int = 0
var rarity_distribution := [
	[96, 1, 1, 1, 1],
	[77, 10, 10, 1, 1],
	[48, 20, 20, 10, 1],
	[31, 25, 25, 15, 3],
	[29, 25, 25, 15, 5],
	[26, 20, 20, 25, 8]
]
var rarity_picker: RarityPicker
var submit_left: int = 0
var modify_left: int = 0

func _ready() -> void:
	rng.randomize()
	_load_catalog()
	rarity_picker = RarityPicker.new(rarity_distribution, luck)
	if score_controller:
		score_controller.count_finished.connect(_on_count_finished)
		score_controller.round_changed.connect(_on_round_changed)
	if start_round_button:
		start_round_button.pressed.connect(start_round)
	if submit_button:
		submit_button.pressed.connect(submit_round)
	if star_choice_ui:
		star_choice_ui.refresh.connect(open_star_choice_ui)
		if not star_choice_ui.star_added.is_connected(_on_star_chosen):
			star_choice_ui.star_added.connect(_on_star_chosen)
		open_star_choice_ui()
	exam_level = exam_level
	submit_left_changed.emit(submit_left)
	modify_left_changed.emit(modify_left)

func _load_catalog() -> bool:
	if not ResourceLoader.exists(STARSET_PATH):
		catalog = null
		push_error("加载星曜表失败：文件不存在：%s" % STARSET_PATH)
		return false
	var loaded_resource: Resource = ResourceLoader.load(STARSET_PATH)
	if not loaded_resource:
		catalog = null
		push_error("加载星曜表失败：ResourceLoader.load 返回空：%s" % STARSET_PATH)
		return false
	if not (loaded_resource is StarSet):
		catalog = null
		push_error("加载星曜表失败：资源类型不是 StarSet：%s" % STARSET_PATH)
		return false
	catalog = loaded_resource as StarSet
	catalog.build_rarity_index()
	if catalog.starset_total.is_empty():
		push_error("加载星曜表失败：starset_total 为空：%s" % STARSET_PATH)
		return false
	print("加载星曜表成功：%s，星曜数量：%d" % [STARSET_PATH, catalog.starset_total.size()])
	return true

func start_round() -> void:
	if not catalog:
		return
	_clear_palace()
	round_started.emit()
	if ui_manager:
		await ui_manager.PlayRoundStartTween()
	await _distribute_inventory()
	stars_distributed.emit()

func submit_round() -> void:
	if score_controller:
		score_controller.count_score()

func _on_count_finished() -> void:
	round_scored.emit()
	if ui_manager:
		ui_manager.round_end_dynamic_effect()
	await get_tree().create_timer(0.8).timeout
	open_star_choice_ui()

func _on_round_changed(new_round: int, _target_score: int) -> void:
	exam_level = new_round

func open_star_choice_ui() -> void:
	if not star_choice_ui:
		return
	var wait_list: Array[StarData] = []
	for i in range(3):
		var random_star: StarData = pick_random_star(0)
		if random_star:
			wait_list.append(random_star)
	if wait_list.is_empty():
		return
	star_choice_ui.add_unchose_starset(wait_list)
	star_choice_ui.visible = true

func _on_star_chosen(star_data: StarData) -> void:
	add_or_upgrade_star(star_data)

func add_or_upgrade_star(star_data: StarData) -> void:
	if not star_data:
		return
	for star in inventory:
		if star.data.star_id == star_data.star_id:
			star.level += 1
			_play_upgrade_effect(star)
			update_backpack_ui()
			return
	var new_star: StarInstance = StarInstance.new(star_data, star_data.level)
	inventory.append(new_star)
	update_backpack_ui()

func _play_upgrade_effect(star: StarInstance) -> void:
	var star_icon: StarIcon = STAR_TEXT_NODE.instantiate()
	get_tree().root.add_child(star_icon)
	star_icon.initial(star)
	star_icon.global_position = get_viewport().size * 0.5 - star_icon.size * 0.5
	star_icon.upgrade_effect()
	star_icon.scale = Vector2(5, 5)
	AudioPlayer.audio_play(UPGRADE_SOUND)
	await get_tree().create_timer(0.9).timeout
	star_icon.queue_free()

func _distribute_inventory() -> void:
	for star in inventory:
		star.in_palace = false
		star.palace_index = -1
	for star in inventory:
		var palace_index := rng.randi_range(0, 11)
		_place_star_in_palace(palace_index, star)
		await get_tree().create_timer(0.3).timeout

func _place_star_in_palace(palace_index: int, star: StarInstance) -> void:
	if not star_panel:
		return
	star.palace_index = palace_index
	star.in_palace = true
	var palace: PalaceContainer = star_panel.find_palace(palace_index)
	if not palace:
		return
	var star_icon: StarIcon = STAR_TEXT_NODE.instantiate()
	star_icon.can_drop.connect(star_panel.reset_staricon)
	palace.add_star(star_icon)
	star_icon.initial(star)
	AudioPlayer.audio_play(ADD_SOUND)

func pick_random_star(rarity_mode: int = -1) -> StarData:
	if not catalog or catalog.starset_total.is_empty():
		return null
	if rarity_mode == -1:
		return catalog.starset_total[rng.randi_range(0, catalog.starset_total.size() - 1)]
	if rarity_mode == 0:
		var chosen_rarity := rarity_picker.pick_rarity(rng, exam_level)
		return _pick_from_rarity(chosen_rarity)
	return _pick_from_rarity(rarity_mode)

func _pick_from_rarity(rarity: int) -> StarData:
	if catalog.starset_rarity.is_empty():
		catalog.build_rarity_index()
	var pool: Array = catalog.starset_rarity.get(rarity, []) as Array
	if pool.is_empty():
		return catalog.starset_total[rng.randi_range(0, catalog.starset_total.size() - 1)]
	return pool[rng.randi_range(0, pool.size() - 1)]

func update_backpack_ui() -> void:
	if not star_backpack:
		return
	clear_backpack_ui()
	for star in inventory:
		_add_to_backpack(star)

func _add_to_backpack(star: StarInstance) -> void:
	var star_icon: StarIcon = STAR_TEXT_NODE.instantiate()
	star_backpack.add_child(star_icon)
	star_icon.initial(star)

func clear_backpack_ui() -> void:
	for child in star_backpack.get_children():
		star_backpack.remove_child(child)
		child.queue_free()

func _clear_palace() -> void:
	if not star_panel:
		return
	for star in inventory:
		star.palace_index = -1
		star.in_palace = false
	for i in range(12):
		var palace: PalaceContainer = star_panel.find_palace(i)
		if palace:
			palace.clear()

func get_stars_in_palaces(palace_indices: Array[int]) -> Array[StarInstance]:
	var result: Array[StarInstance] = []
	if not star_panel:
		return result
	for index in palace_indices:
		var palace: PalaceContainer = star_panel.find_palace(index)
		if not palace:
			continue
		for star_icon: StarIcon in palace.get_stars():
			result.append(star_icon.star_instance)
	return result

func _on_add_random_star_pressed() -> void:
	print("add_random_star: begin")
	if not catalog:
		print("add_random_star: catalog 为空，尝试重新加载 %s" % STARSET_PATH)
		if not _load_catalog():
			push_error("创建星曜实例失败：catalog 未加载，无法从 %s 读取星曜数据" % STARSET_PATH)
			return
	if catalog.starset_total.is_empty():
		push_error("创建星曜实例失败：catalog.starset_total 为空，没有可创建的星曜数据")
		return
	if not rarity_picker:
		push_error("创建星曜实例失败：rarity_picker 未初始化，无法按稀有度抽取星曜")
		return
	if not star_backpack:
		push_error("创建星曜实例失败：star_backpack 未连接，无法添加到 Board/Panel/Label/StarBag")
		return
	var random_star: StarData = pick_random_star(0)
	if not random_star:
		push_error("创建星曜实例失败：pick_random_star(0) 返回 null")
		return
	if random_star.star_id == "" or random_star.star_name == "":
		push_error("创建星曜实例失败：抽到的 StarData 缺少 star_id 或 star_name")
		return
	if random_star.texture_path == "":
		push_error("创建星曜实例失败：%s 没有 texture_path" % random_star.star_name)
		return
	if not ResourceLoader.exists(random_star.texture_path):
		push_error("创建星曜实例失败：%s 的图标路径不存在：%s" % [random_star.star_name, random_star.texture_path])
		return
	var new_star: StarInstance = StarInstance.new(random_star, random_star.level)
	if not new_star or not new_star.data:
		push_error("创建星曜实例失败：StarInstance.new() 未返回有效实例")
		return
	var star_icon_node: Node = STAR_TEXT_NODE.instantiate()
	if not star_icon_node or not (star_icon_node is StarIcon):
		push_error("创建星曜实例失败：StarTextNode.tscn 未能实例化为 StarIcon")
		return
	var star_icon: StarIcon = star_icon_node as StarIcon
	inventory.append(new_star)
	star_backpack.add_child(star_icon)
	star_icon.initial(new_star)
	print("add_random_star: 创建星曜实例成功：%s，图标路径：%s，当前背包数量：%d" % [random_star.star_name, random_star.texture_path, inventory.size()])
