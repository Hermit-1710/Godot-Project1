# ROLE: Runtime star state attached to a StarData.
# OWNS: data, level, scores, multipliers, palace placement.
# TALKS_TO: StarData.
# API: get_base_score, get_total_score.
# INVARIANTS: data is a valid StarData reference.
extends RefCounted
class_name StarInstance

var data: StarData
var level: int = 1
var temp_score: int = 0
var perm_score: int = 0
var temp_multiplier: int = 0
var perm_multiplier: int = 0
var palace_index: int = -1
var in_palace: bool = false

func _init(star_data: StarData, base_level: int = 1) -> void:
	data = star_data
	level = base_level

func get_base_score() -> int:
	if data and data.score:
		return data.score.base_score
	return 0

func get_total_score() -> int:
	var base = get_base_score() + temp_score + perm_score
	var mult = 1 + temp_multiplier + perm_multiplier
	if mult < 1:
		mult = 1
	return base * mult
