# ROLE: Star icon view with drag, hover, and score effects.
# OWNS: star_instance, hover tween, popup reference.
# TALKS_TO: GlobalDragManager, StarInfoPop, PalaceContainer signals, AudioPlayer.
# API: initial, count_score_dynamic_effect, upgrade_effect.
# INVARIANTS: star_instance may be null; UI nodes exist in scene.
extends Container
class_name StarIcon

const STAR_INFO := preload("res://scene/Autoload/StarInfo.tscn")
const UNKNOWN_STAR_TEXTURE := "res://assets/star_ICONS/未知星.png"
const STAR_TEXT_NODE := preload("res://scene/starText/StarTextNode.tscn")

@export var center_position: Vector2 = Vector2.ZERO
@export var radius: float = 1.0
@export var rotate_speed: float = 1.0

@onready var node_2d: Node2D = get_node_or_null("Node2D")
@onready var shadow: TextureRect = get_node_or_null("%shadow")
@onready var text: TextureRect = %Sprite2D
@onready var score_ui: Label = $SCORE_UI
@onready var upgrade_particles: GPUParticles2D = $GPUParticles2D

signal can_drop(staricon: StarIcon, new_palace_index: int)
signal highlight_palace
signal normal_palace

var star_instance: StarInstance
var star_info: StarInfo
var tween_hover: Tween
var time_passed: float = 0.0
var origin_position: Vector2

func _ready() -> void:
	score_ui.visible = false
	pivot_offset = size * 0.5
	origin_position = position
	if not mouse_entered.is_connected(_on_mouse_entered):
		mouse_entered.connect(_on_mouse_entered)
	if not mouse_exited.is_connected(_on_mouse_exited):
		mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	time_passed += delta
	_idle_motion(time_passed)

func _idle_motion(t: float) -> void:
	if origin_position == Vector2.ZERO:
		origin_position = position
	var offset_x = radius * cos(t * rotate_speed)
	var offset_y = radius * sin(t * rotate_speed)
	position = origin_position + Vector2(offset_x, offset_y)

func initial(instance: StarInstance) -> void:
	star_instance = instance
	_load_texture()
	_load_star_info()

func _load_texture() -> void:
	var texture_instance: Texture2D
	if star_instance and star_instance.data and star_instance.data.texture_path != "":
		texture_instance = load(star_instance.data.texture_path)
		print("加载星曜图标成功")
	else:
		push_warning("Missing star texture, use fallback.")
		texture_instance = load(UNKNOWN_STAR_TEXTURE)
	text.texture = texture_instance

func _load_star_info() -> void:
	if not star_instance or not star_instance.data:
		return
	if star_instance.data.starinfo_packed_path != "":
		var packed_scene = load(star_instance.data.starinfo_packed_path)
		if packed_scene:
			star_info = packed_scene.instantiate()
			star_info.visible = false
			add_child(star_info)
		else:
			push_error("Cannot load scene: %s" % star_instance.data.starinfo_packed_path)

func _on_mouse_entered() -> void:
	AudioPlayer.button_click()
	_play_hover_effect()
	_show_star_info()
	GlobalDragManager.is_hovering = true
	if star_instance and star_instance.in_palace:
		highlight_palace.emit()

func _on_mouse_exited() -> void:
	if star_instance and star_instance.in_palace:
		normal_palace.emit()
	GlobalDragManager.is_hovering = false
	if star_info:
		star_info.visible = false
	StarInfoPop.visible = false
	_stop_hover_effect()

func _show_star_info() -> void:
	if not star_instance or not star_instance.data:
		return
	if star_info:
		star_info.visible = true
		_show_popup_at(get_global_mouse_position())
	else:
		StarInfoPop.visible = true
		StarInfoPop.init(star_instance.data)
		_show_popup_at(get_global_mouse_position(), StarInfoPop)

func _show_popup_at(global_pos: Vector2, popup: Control = null) -> void:
	var target = popup if popup else star_info
	if not target:
		return
	var final_pos = global_pos + Vector2(10, 10)
	var popup_size = target.size
	var viewport_size = get_viewport_rect().size
	if final_pos.x + popup_size.x > viewport_size.x:
		final_pos.x -= popup_size.x + 10
	if final_pos.y + popup_size.y > viewport_size.y:
		final_pos.y -= popup_size.y
	target.global_position = final_pos

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if GlobalDragManager.star_temp and GlobalDragManager.star_temp.is_inside_tree():
				GlobalDragManager.star_temp.queue_free()
			var star_temp: StarIcon = STAR_TEXT_NODE.instantiate()
			get_tree().root.add_child(star_temp)
			star_temp.visible = false
			star_temp.initial(star_instance)
			star_temp.mouse_filter = Control.MOUSE_FILTER_IGNORE
			GlobalDragManager.star_temp = star_temp
			GlobalDragManager.is_dragging = true
			GlobalDragManager.drag_offset = global_position - get_viewport().get_mouse_position()
			modulate = Color.TRANSPARENT
		elif event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			GlobalDragManager.is_dragging = false
			if GlobalDragManager.hovered_palace_index >= 0:
				if star_instance and GlobalDragManager.hovered_palace_index != star_instance.palace_index:
					can_drop.emit(self, GlobalDragManager.hovered_palace_index)
			if GlobalDragManager.star_temp and GlobalDragManager.star_temp.is_inside_tree():
				GlobalDragManager.star_temp.queue_free()
				GlobalDragManager.star_temp = null
			modulate = Color.WHITE

func count_score_dynamic_effect(score_value: int = 0) -> void:
	if score_value <= 0:
		return
	var original_pos = position
	var up_pos = original_pos + Vector2(0, -40)
	score_ui.text = "+ %d" % score_value
	score_ui.global_position = global_position + Vector2(0, -80)
	var target_pos = score_ui.global_position + Vector2(0, -60)
	score_ui.self_modulate.a = 0
	score_ui.visible = true
	var tween_count = get_tree().create_tween()
	tween_count.tween_property(score_ui, "global_position", target_pos, 0.15)
	tween_count.parallel().tween_property(score_ui, "self_modulate:a", 1, 0.1)
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = get_tree().create_tween()
	tween_hover.tween_property(self, "position", up_pos, 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.chain().tween_property(self, "rotation_degrees", 20, 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.chain().tween_property(self, "rotation_degrees", -14, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.chain().tween_property(self, "rotation_degrees", 10, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.chain().tween_property(self, "rotation_degrees", 0, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.chain().tween_property(self, "position", original_pos, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.5).timeout
	score_ui.visible = false

func _play_hover_effect() -> void:
	pivot_offset = size * 0.5
	var angle = 20
	var center_pos = position + pivot_offset
	if get_global_mouse_position().x < center_pos.x:
		angle = -20
	tween_hover = get_tree().create_tween()
	tween_hover.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(self, "rotation_degrees", angle, 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_delay(0.05)
	tween_hover.tween_property(self, "rotation_degrees", -angle * 0.7, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(self, "rotation_degrees", angle * 0.5, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(self, "rotation_degrees", 0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _stop_hover_effect() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = get_tree().create_tween()
	tween_hover.tween_property(self, "rotation_degrees", 0, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_hover.parallel().tween_property(self, "scale", Vector2(1.0, 1.0), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func upgrade_effect() -> void:
	upgrade_particles.emitting = true
	_play_hover_effect()

func get_star_instance() -> StarInstance:
	return star_instance
