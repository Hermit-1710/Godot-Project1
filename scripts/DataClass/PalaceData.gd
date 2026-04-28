# ROLE: Runtime palace data container.
# OWNS: palace_id, index, stars_in_palace, notes.
# TALKS_TO: StarInstance.
# API: add_star, get_star_count, find_star_by_id.
# INVARIANTS: stars_in_palace stores StarInstance only.
extends Node
class_name PalaceData

enum PalaceId {
	MING,
	XIONGDI,
	FUQI,
	ZINV,
	CAIBO,
	JIE,
	QIANYI,
	PUYI,
	GUANLU,
	TIANZHAI,
	FUDU,
	FUMU
}

var palace_id: PalaceId = PalaceId.MING
var index: int = -1
var stars_in_palace: Array[StarInstance] = []
var notes: String = ""
var palace_gan: String = ""
var palace_zhi: String = ""

func add_star(star: StarInstance) -> void:
	if star:
		stars_in_palace.append(star)

func get_star_count() -> int:
	return stars_in_palace.size()

func find_star_by_id(star_id: String) -> StarInstance:
	for s in stars_in_palace:
		if s and s.data and s.data.star_id == star_id:
			return s
	return null
