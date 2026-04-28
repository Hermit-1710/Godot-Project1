# ROLE: Star info card UI for selection panels.
# OWNS: UI nodes for name, classification, description, level.
# TALKS_TO: StarData, GameButton.
# API: init, show_button, hide_button, be_chose.
# INVARIANTS: UI nodes exist in StarInfo scene.
extends PanelContainer
class_name StarInfo

var texture_rect: TextureRect
var button: GameButton
var label_name: Label
var label_classification: Label
var desc_box: VBoxContainer
var star_level_ui: VBoxContainer

const UNKNOWN_STAR_TEXTURE := "res://assets/star_ICONS/未知星.png"
const LEVEL_UI := preload("res://scene/starInfo/level_Ui.tscn")

var title_colorlist = [
	Color.BLACK,
	Color.GREEN,
	Color.BLUE,
	Color.PURPLE,
	Color.RED,
	Color.GOLD
]

signal chose

func _ready() -> void:
	_resolve_ui_nodes()
	if button:
		hide_button()
		button.pressed.connect(be_chose)
	visible = false

func be_unchose() -> void:
	show_button()

func be_chose() -> void:
	chose.emit()

func hide_button() -> void:
	_resolve_ui_nodes()
	if button:
		button.visible = false

func show_button() -> void:
	_resolve_ui_nodes()
	if button:
		button.visible = true

func init(star_data: StarData) -> void:
	if not star_data:
		return
	_resolve_ui_nodes()
	if not label_name or not label_classification or not star_level_ui:
		push_error("StarInfo.init failed: missing required UI nodes in %s" % get_path())
		return
	var rarity_int = int(star_data.rarity)
	var shader_path = "res://shader/rarity_color/%d.tres" % rarity_int
	theme = load(shader_path)
	var title_color = title_colorlist[clamp(rarity_int, 0, title_colorlist.size() - 1)]

	var star_texture: Texture2D
	if star_data.texture_path != "":
		star_texture = load(star_data.texture_path)
	else:
		push_warning("Missing star texture: %s" % star_data.star_name)
		star_texture = load(UNKNOWN_STAR_TEXTURE)
	if texture_rect:
		texture_rect.texture = star_texture

	label_name.text = star_data.star_name
	label_name.modulate = title_color

	for child in star_level_ui.get_children():
		star_level_ui.remove_child(child)
		child.queue_free()
	if star_data.level > 0:
		for i in range(star_data.level):
			var star = LEVEL_UI.instantiate()
			star_level_ui.add_child(star)
			var mat = star.material
			if mat is ShaderMaterial:
				mat.set_shader_parameter("level", star_data.level)

	label_classification.text = ""
	if star_data.wu_xing != "":
		label_classification.text += " " + star_data.wu_xing
	if star_data.yin_yang != "":
		label_classification.text += " " + star_data.yin_yang
	if label_classification.text == "":
		label_classification.text = "无"

	if desc_box:
		for child in desc_box.get_children():
			desc_box.remove_child(child)
			child.queue_free()

	var desc_base_value = RichTextLabel.new()
	desc_base_value.bbcode_enabled = true
	desc_base_value.custom_minimum_size = Vector2(0, 50)
	if star_data.score:
		desc_base_value.text = "[color=#f9d5a1]基础得分[/color] : [color=green]+%d[/color]" % star_data.score.base_score
	if desc_box:
		desc_box.add_child(desc_base_value)

	for i in range(star_data.description.size()):
		var desc_node = RichTextLabel.new()
		desc_node.bbcode_enabled = true
		desc_node.custom_minimum_size = Vector2(0, 50)
		desc_node.text = star_data.description[i]
		if desc_box:
			desc_box.add_child(desc_node)

func _resolve_ui_nodes() -> void:
	if not texture_rect:
		texture_rect = _get_node_from_unique_or_path("%startexture", "MarginContainer/VBoxContainer/星曜 图标&Title/startexture") as TextureRect
	if not button:
		button = _get_node_from_unique_or_path("%Button", "MarginContainer/VBoxContainer/Button") as GameButton
	if not label_name:
		label_name = _get_node_from_unique_or_path("%name", "MarginContainer/VBoxContainer/星曜 图标&Title/VBoxContainer/name") as Label
	if not label_classification:
		label_classification = _get_node_from_unique_or_path("%classification", "MarginContainer/VBoxContainer/星曜 图标&Title/VBoxContainer/classification") as Label
	if not desc_box:
		desc_box = _find_desc_box()
	if not star_level_ui:
		star_level_ui = _get_node_from_unique_or_path("%星曜等级", "MarginContainer/星曜等级") as VBoxContainer

func _get_node_from_unique_or_path(unique_path: NodePath, fallback_path: NodePath) -> Node:
	var node: Node = get_node_or_null(unique_path)
	if node:
		return node
	return get_node_or_null(fallback_path)

func _find_desc_box() -> VBoxContainer:
	var root = get_node_or_null("MarginContainer/VBoxContainer")
	if not root:
		return null
	var by_name = root.get_node_or_null("说明")
	if by_name and by_name is VBoxContainer:
		return by_name
	for child in root.get_children():
		if child is VBoxContainer and child.name != "星曜等级":
			return child
	return null
