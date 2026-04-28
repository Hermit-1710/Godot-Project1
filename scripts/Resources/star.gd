# ROLE: Star prototype data (immutable during runtime).
# OWNS: id, name, rarity, texture_path, description, score.
# TALKS_TO: Score (resource).
# API: has_tag.
# INVARIANTS: do not mutate runtime state here.
extends Resource
class_name StarData

@export var star_id: String = ""
@export var star_name: String = ""
@export var rarity: int = 0
@export var texture_path: String = ""
@export var description: Array[String] = []
@export var starinfo_packed_path: String = ""
@export var tags: Array[String] = []
@export var element_id: String = ""
@export var wu_xing: String = ""
@export var yin_yang: String = ""
@export var level: int = 1 # As a base level, do not modify at runtime.
@export var score: Score

func has_tag(tag: String) -> bool:
	for _tag in tags:
		if _tag == tag:
			return true
	return false
