# ROLE: Text popup for star info (texture variant).
# OWNS: none (UI nodes in scene).
# TALKS_TO: StarData.
# API: init, set_star_info, show_popup_at, hide_popup.
# INVARIANTS: expected label nodes exist in popup scene.
extends PanelContainer
class_name StarInfoTextPopup

func _ready() -> void:
	visible = false

func init(star_data: StarData) -> void:
	_set_star_info(star_data)

func set_star_info(data) -> void:
	_set_star_info(data)

func _set_star_info(data) -> void:
	if data == null:
		return
	var label_name = _get_label(["星耀", "星曜"])
	var label_wuxing = _get_label(["五行"])
	var label_yinyang = _get_label(["阴阳"])
	var label_effect = _get_label(["效果"])
	var label_desc = _get_label(["描述"])
	if data is StarData:
		if label_name:
			label_name.text = data.star_name
		if label_wuxing:
			label_wuxing.text = data.wu_xing
		if label_yinyang:
			label_yinyang.text = data.yin_yang
		if label_effect:
			label_effect.text = "得分: %s" % (data.score.base_score if data.score else 0)
		if label_desc:
			label_desc.text = "\n".join(data.description)
	elif typeof(data) == TYPE_DICTIONARY:
		if label_name:
			label_name.text = str(data.get("星曜名称", ""))
		if label_wuxing:
			label_wuxing.text = str(data.get("五行", ""))
		if label_yinyang:
			label_yinyang.text = str(data.get("阴阳", ""))
		if label_effect:
			label_effect.text = "得分: %s" % str(data.get("得分", ""))
		if label_desc:
			label_desc.text = str(data.get("描述", ""))

func show_popup_at(global_pos: Vector2) -> void:
	visible = true
	var final_pos = global_pos + Vector2(10, 10)
	var popup_size = size
	var viewport_size = get_viewport_rect().size
	if final_pos.x + popup_size.x > viewport_size.x:
		final_pos.x -= popup_size.x + 10
	if final_pos.y + popup_size.y > viewport_size.y:
		final_pos.y -= popup_size.y
	global_position = final_pos

func hide_popup() -> void:
	visible = false

func _get_label(names: Array[String]) -> Label:
	for property_name in names:
		var node = get_node_or_null("%" + property_name)
		if node and node is Label:
			return node
	return null
