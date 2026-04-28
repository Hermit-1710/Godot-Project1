# StarsDatabase.gd
extends Resource
class_name StarsDatabase

# 用于存储星曜数据的数组或字典
# 可以用 Array，也可以用 Dictionary。这里用 Array，每个元素是 {name,分类,分派...} 的 Dictionary
@export var stars_data: Array = []
