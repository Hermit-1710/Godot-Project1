# ROLE: Score calculator for star instances.
# OWNS: none.
# TALKS_TO: StarInstance.
# API: score_star.
# INVARIANTS: star_instance can be null.
extends RefCounted
class_name ScoreCalculator

func score_star(star_instance: StarInstance) -> int:
	if not star_instance:
		return 0
	return star_instance.get_total_score()
