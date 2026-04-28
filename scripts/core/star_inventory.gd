# ROLE: Runtime inventory for star instances and upgrades.
# OWNS: items list and upgrade logic.
# TALKS_TO: StarInstance, StarData.
# API: find_by_id, add_new, reset_palace_flags, clear.
# INVARIANTS: items contains StarInstance only.
extends RefCounted
class_name StarInventory

signal changed

var items: Array[StarInstance] = []

func find_by_id(star_id: String) -> StarInstance:
	for star in items:
		if star.data.star_id == star_id:
			return star
	return null

func add_new(star_data: StarData) -> StarInstance:
	var new_star := StarInstance.new(star_data, star_data.level)
	items.append(new_star)
	changed.emit()
	return new_star

func reset_palace_flags() -> void:
	for star in items:
		star.palace_index = -1
		star.in_palace = false

func clear() -> void:
	items.clear()
	changed.emit()
