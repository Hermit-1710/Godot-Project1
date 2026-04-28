extends Node
#每个星曜将包括
#name: 星曜名称
#trigger:
#	phase: 触发时机（如 on_entry、resolution_start、passive_outside 等）
#	condition: {
#		target_type: "self" | "adjacent" | "same_palace" | "global" 等
#		condition_type: "count_ge" | "type_match" | "moved" | "random_chance" 等
#		star_type: 目标星曜类型（如 "财星"、"主星"、星曜名等）
#		value: 比较值（如数量≥X）}
#effect:
#	type: "add_score" | "spawn_star" | "protect_star" | "copy_effect" | "add_currency" | "multiply_score" | "increase_rarity" 等
#	parameters: 效果参数对象，例如：{"value": 100, "duration": "temporary", "target": "adjacent"}等）
const STAR_RULES: Dictionary = {
	"紫薇": {
		"base_value": 5,
		"tags": ["帝星",""],
		"synergy_rules": [
			{	"trigger": {
					"phase": "resolution_start",
					"type": "count",
					"condition": {
						"palaces":"三方四正",
						"target": "辅佐星"
						}
					},	
				"effect": { 
					"type": "add_mutiple",
					"parameters": {
						"target": "palaces",
						"scope": "三方四正",
						"duration":"temporary",
						}
					}
			},
			{
				"condition": { "type": "adjacent_count", "tag": "water", "min": 2 },
				"effect": { "type": "multiply", "factor": 2 }
			}
		]
	},

	"天机": {
		"synergy_rules": [
			{
				"condition": { "type": "exists", "target": "ziwei" },
				"effect": { "type": "add", "value": 3 }
			},
			{
				"condition": { "type": "exists", "target": "ziwei" },
				"effect": { "type": "add", "value": 3 }
			}
		]
	},
	
	
	"武曲": {
		"synergy_rules": [
			{
				"condition":{"check_palace":"同宫","type":"exist_isolated","target":-1},
				"effect":{"check_palace":"无","type":"加分永久","target":"self","value":3}	
			}
		]
	}
}
