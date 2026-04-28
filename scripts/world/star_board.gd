# ROLE: Star board panel with palace lookup and highlight effects.
# OWNS: palace_minimum_size, group membership.
# TALKS_TO: PalaceContainer, GlobalDragManager, StarIcon.
# API: find_palace, reset_staricon, hightlight_starpanel, normal_starpanel.
# INVARIANTS: palace children exist for indices 0..11.
extends GridContainer
class_name StarPanel

@export var texture: Texture2D
@export var group_name: String
@export var palace_minimum_size: int = 100

signal star_moved(old_index: int, new_index: int)

func _ready() -> void:
	add_to_group("star_panel")
	for child in get_children():
		if child is PalaceContainer:
			child.hovered_star_entered.connect(star_hovered)
			child.hovered_star_exited.connect(normal_starpanel)
	set_palace_minimum_size(palace_minimum_size)

func set_palace_minimum_size(size: int) -> void:
	for child in get_children():
		if child is Container or child is PanelContainer:
			child.custom_minimum_size = Vector2(size, size)

func find_palace(target_palace_index: int) -> PalaceContainer:
	for child in get_children():
		if child is PalaceContainer and child.palace_index == target_palace_index:
			return child
	return null

func reset_staricon(staricon: StarIcon, new_palace_index: int) -> void:
	var new_parent: PalaceContainer = find_palace(new_palace_index)
	if not new_parent:
		return
	var old_index := -1
	if staricon.star_instance:
		old_index = staricon.star_instance.palace_index
	staricon.reparent(new_parent.star_container)
	if staricon.star_instance:
		staricon.star_instance.palace_index = new_palace_index
		staricon.star_instance.in_palace = true
	if old_index != new_palace_index:
		star_moved.emit(old_index, new_palace_index)

func star_hovered() -> void:
	if GlobalDragManager.hovered_palace_index >= 0:
		hightlight_starpanel(GlobalDragManager.hovered_palace_index)

func hightlight_starpanel(palace_index: int) -> void:
	for index in range(12):
		var palace := find_palace(index)
		if palace:
			palace.set_forbidden_color()
	var center_palace := find_palace(palace_index)
	if center_palace:
		center_palace.set_normal_color()
	var effect_palace_list_index = [(palace_index + 4) % 12, (palace_index + 6) % 12, (palace_index + 8) % 12]
	for effect_palace_index in effect_palace_list_index:
		var effect_palace := find_palace(effect_palace_index)
		if effect_palace:
			effect_palace.set_effected_color()

func normal_starpanel() -> void:
	for index in range(12):
		var palace := find_palace(index)
		if palace:
			palace.set_normal_color()
