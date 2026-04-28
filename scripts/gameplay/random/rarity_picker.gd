# ROLE: Rarity selection helper for star picking.
# OWNS: distribution table, luck.
# TALKS_TO: none.
# API: pick_rarity.
# INVARIANTS: distribution rows sum near 100 before luck.
extends RefCounted
class_name RarityPicker

var distribution: Array = []
var luck: int = 0

func _init(base_distribution: Array, luck_value: int) -> void:
	distribution = base_distribution.duplicate(true)
	luck = luck_value

func pick_rarity(rng: RandomNumberGenerator, exam_level: int) -> int:
	if distribution.is_empty():
		return 1
	var index: int = clampi(exam_level, 0, distribution.size() - 1)
	var row: Array = distribution[index].duplicate()
	for i in range(1, row.size()):
		row[i] = max(0, row[i] + luck)
	var total := 0
	for i in range(1, row.size()):
		total += row[i]
	var roll_max := 100
	if total >= 100:
		row[0] = 0
		roll_max = total
	else:
		row[0] = 100 - total
	var roll := rng.randi_range(1, roll_max)
	var cumulative := 0
	for i in range(row.size()):
		cumulative += row[i]
		if roll <= cumulative:
			return i + 1
	return 1
