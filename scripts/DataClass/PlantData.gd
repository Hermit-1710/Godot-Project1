extends Resource
class_name PlantData

# 基础属性，通过 @export (Godot 4) 暴露到Inspector便于编辑
@export var plant_name: String = "Unnamed Plant"

# 需求阈值 - 表示该作物理想情况下所需要的环境数值
@export var water_need: int = 50
@export var sunlight_need: int = 50
@export var fertility_need: int = 50

# 作物最终需要的“成长总值”，达到或超过则视为成熟
@export var total_growth_needed: int = 100

# 当前生长值 - 在游戏中根据环境判定逐回合/每帧增减
var current_growth: int = 0

# 固定生长时长（回合/天数/阶段等），到期收获
@export var growth_duration: int = 5
var current_age: int = 0  # 已经历回合计数


# 初始化方法 - 可选
func _init(name: String = "Unnamed Plant",
		   water_threshold: int = 50,
		   sunlight_threshold: int = 50,
		   fertility_threshold: int = 50,
		   growth_goal: int = 100,
		   duration: int = 5):
	plant_name = name
	water_need = water_threshold
	sunlight_need = sunlight_threshold
	fertility_need = fertility_threshold
	total_growth_needed = growth_goal
	growth_duration = duration
	current_growth = 0
	current_age = 0

# 每回合/每周期更新生长逻辑
# environment_* 参数表示此回合/当前环境的水分、阳光、肥力等值
func update_growth(environment_water: int,
				   environment_sunlight: int,
				   environment_fertility: int) -> void:
	# 基础增量，用于计算本回合作物能得到多少成长值
	var growth_increment = 0

	# 简单判定：每达标1项，就额外+3 成长
	# （你可按自己的设计细化）
	#if environment_water >= water_need:
	growth_increment += 3
	#if environment_sunlight >= sunlight_need:
	growth_increment += 3
	#if environment_fertility >= fertility_need:
	growth_increment += 3

	# 如果环境极度不匹配，也可在此处加入负值或病害逻辑
	# if environment_water < water_need / 2:
	#     growth_increment -= 1

	# 更新本回合的成长值
	current_growth += growth_increment
	# 保证不超出上限
	current_growth = clamp(current_growth, 0, total_growth_needed)

	# 增加"年龄"或"经过回合"
	current_age += 1
		
		

# 判断是否已达到成熟
func is_mature() -> bool:
	return current_growth >= total_growth_needed

# 判断是否到达固定生长时长
func can_harvest() -> bool:
	return current_age >= growth_duration

# 返回一个综合评分或品质，简单举例
# 可根据 current_growth / total_growth_needed 的比例决定收成质量
func get_quality() -> String:
	var ratio = float(current_growth) / float(total_growth_needed)
	if ratio >= 0.9:
		return "Excellent"
	elif ratio >= 0.6:
		return "Good"
	elif ratio >= 0.3:
		return "Poor"
	else:
		return "Failed"
