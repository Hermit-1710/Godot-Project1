# ROLE: Balance configuration for rarity and scoring targets.
# OWNS: rarity_distribution, target_score_list, exam_names, luck.
# TALKS_TO: GameController, ScoreController.
# API: none.
# INVARIANTS: rarity_distribution rows align with exam levels.
extends Resource
class_name StarBalance

@export var rarity_distribution: Array = []
@export var target_score_list: Array = []
@export var exam_names: Array = []
@export var luck: int = 0
