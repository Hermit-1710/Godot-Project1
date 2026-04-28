# ROLE: Star collection and rarity index.
# OWNS: starset_total, starset_rarity, starset_temp.
# TALKS_TO: StarData.
# API: build_rarity_index.
# INVARIANTS: starset_rarity mirrors starset_total.
extends Resource
class_name StarSet

@export var starset_total: Array[StarData]
@export var starset_rarity: Dictionary
@export var starset_temp: Array[StarData]

func build_rarity_index() -> void:
	starset_rarity = {}
	for i in range(1, 6):
		starset_rarity[i] = []
	for stardata in starset_total:
		if not stardata:
			continue
		if not starset_rarity.has(stardata.rarity):
			starset_rarity[stardata.rarity] = []
		starset_rarity[stardata.rarity].append(stardata)
