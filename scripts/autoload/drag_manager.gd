# ROLE: Global drag controller for star drag-and-drop.
# OWNS: star_temp, drag_offset, hovered_palace_index, is_dragging.
# TALKS_TO: StarIcon.
# API: is_dragging setter, _process.
# INVARIANTS: star_temp created during drag start.
extends Node2D
class_name Global_Drag_Manager

var star_temp: StarIcon
var drag_offset: Vector2
var hovered_palace_index: int = -1
var is_hovering: bool = false
var star_panel: StarPanel

var is_dragging: bool:
	set(val):
		is_dragging = val
		if star_temp:
			star_temp.visible = val
		set_process(val)
		set_process_input(val)

func _ready() -> void:
	_find_star_panel()

func _find_star_panel() -> void:
	await get_tree().process_frame
	star_panel = get_tree().get_first_node_in_group("star_panel")

func _process(_delta: float) -> void:
	if not star_temp:
		return
	star_temp.top_level = true
	star_temp.global_position = get_global_mouse_position() + drag_offset
