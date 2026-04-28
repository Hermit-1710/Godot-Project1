extends Node
const OUTPUT_TRES_PATH = "res://data/star_data.tres"
var stars_db:Array[Dictionary]
func _ready() -> void:
	load_csv('res://data/stars.csv')
	
func load_csv(csv_path:String):
	var csv_file
	var titles:PackedStringArray
	

	if FileAccess.file_exists(csv_path):
		csv_file = FileAccess.open(csv_path,FileAccess.READ)
		titles= csv_file.get_csv_line(',')
		while csv_file.get_position()< csv_file.get_length():
			var csv_star:PackedStringArray=csv_file.get_csv_line()
			var star:Dictionary
			for i in titles.size():
				star[titles[i]]=csv_star[i]
			#print(star)
			stars_db.append(star)
	else:
		print('no csv_file exist')
		return
	
	var db_res = StarsDatabase.new()
	db_res.stars_data =stars_db

	# 4) 保存为 .tres
	var err = ResourceSaver.save(db_res, OUTPUT_TRES_PATH)
	if err == OK:
		print("成功将 CSV 数据导出到: ",  OUTPUT_TRES_PATH)
		return true
	else:
		push_error("保存 .tres 失败: " + str(err))
		return false
