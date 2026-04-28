# ROLE: Palace container for stars and hover signaling.
# OWNS: palace_index, star_container, palette colors.
# TALKS_TO: GlobalDragManager, StarIcon.
# API: add_star, clear, get_stars, set_normal_color.
# INVARIANTS: StarContainer node exists.
extends PanelContainer
class_name PalaceContainer

@export_enum("寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥", "子", "丑") var palace_index: int

const PALACE_NAMES = ["寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥", "子", "丑"]

@onready var star_container: GridContainer = %StarContainer
@onready var palace_name: Label = $"地支"
@onready var palace_bg: Panel = $palace_bg

signal hovered_star_entered
signal hovered_star_exited

var is_highlighted: bool = true:
	set(value):
		is_highlighted = value
		if value:
			set_normal_color()
		else:
			set_forbidden_color()

var is_effected: bool = false:
	set(value):
		is_effected = value
		if value:
			set_effected_color()
		else:
			set_forbidden_color()

var color1 = Color.hex(0xcab69bff)
var color2 = Color.hex(0xeccaabff)
var color3 = Color.hex(0xffe6a9ff)
var color4 = Color.hex(0xffe7d2ff)

func _ready() -> void:
	palace_name.text = PALACE_NAMES[palace_index]
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	GlobalDragManager.hovered_palace_index = palace_index
	if GlobalDragManager.is_dragging:
		send_highlight_signal()

func _on_mouse_exited() -> void:
	GlobalDragManager.hovered_palace_index = -1
	send_normal_signal()

func send_highlight_signal() -> void:
	hovered_star_entered.emit()

func send_normal_signal() -> void:
	hovered_star_exited.emit()

func add_star(star: StarIcon) -> void:
	fly_in_dynamic_effect(star)
	star.highlight_palace.connect(send_highlight_signal)
	star.normal_palace.connect(send_normal_signal)
	if star.star_instance:
		star.star_instance.in_palace = true

func clear() -> void:
	for child in star_container.get_children():
		star_container.remove_child(child)
		child.queue_free()

func get_stars() -> Array:
	var stars: Array = []
	if star_container.get_children():
		stars = star_container.get_children()
	return stars

func fly_in_dynamic_effect(star: StarIcon) -> void:
	star.modulate.a = 0
	star_container.add_child(star)
	var init_pos = -Vector2(300, 300)
	var origin_pos = star.position
	await get_tree().create_timer(0.05).timeout
	origin_pos = star.position
	star.position = origin_pos + init_pos
	star.scale = Vector2(0.1, 0.1)
	var tween = get_tree().create_tween()
	tween.tween_property(star, "position", origin_pos, 0.3).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(star, "modulate:a", 1, 0.3)
	tween.parallel().tween_property(star, "rotation_degrees", 1080, 0.3)
	tween.parallel().tween_property(star, "scale", Vector2(1.5, 1.5), 0.3).set_ease(Tween.EASE_IN)
	tween.tween_property(star, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT)

func set_normal_color() -> void:
	palace_bg.visible = true
	modulate = Color.WHITE
	palace_bg.modulate = Color.WHITE

func set_effected_color() -> void:
	palace_bg.visible = true
	modulate = Color.WHITE
	palace_bg.modulate = Color.hex(0x70cfffff)

func set_forbidden_color() -> void:
	palace_bg.visible = true
	modulate = Color.hex(0xad9898ff)
	palace_bg.modulate = Color.hex(0xad9898ff)
