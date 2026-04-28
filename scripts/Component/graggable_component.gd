extends Container
class_name GraggableComponent

const STAR_TEXT_NODE := preload("res://scene/starText/StarTextNode.tscn")

var parent_node
var star_instance: StarInstance

signal can_drop

func _gui_input(event: InputEvent) -> void:
	parent_node = get_parent()
	if parent_node is StarIcon:
		star_instance = parent_node.star_instance
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
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
			modulate = Color.WHITE
