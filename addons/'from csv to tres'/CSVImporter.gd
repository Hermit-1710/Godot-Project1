# CSVImporter.gd  (EditorPlugin 示例)
@tool
extends EditorPlugin

const CSV_PATH = "res://data/stars.csv"  # 你的 CSV 文件位置
const INPUT_CSV_PATH = "res://data/all_starset.csv"
const OUTPUT_STARSET_PATH = "res://data/starset.tres"
var StarsDatabaseRef = preload('res://scripts/DataClass/StarDatabase.gd')

func _enter_tree():
	# 在 Godot 编辑器上方菜单加一个 "CSV -> Tres" 按钮
	add_tool_menu_item("Import CSV to .tres", _on_import_csv_clicked())

func _exit_tree():
	remove_tool_menu_item("Import CSV to .tres")

func _on_import_csv_clicked():
	# 读取 CSV, 转为资源, 保存为 .tres
	#var ok = import_csv_to_stardata_tres(CSV_PATH, OUTPUT_TRES_PATH)
	#
	#if ok:
		#print("CSV 导入成功，生成 .tres 文件: ", OUTPUT_TRES_PATH)
	#else:
		#print("CSV 导入失败")
	
	print(FileAccess.file_exists("res://data/all_starset.csv"))
	var _ok = import_csv_to_starset_tres(INPUT_CSV_PATH,OUTPUT_STARSET_PATH)
	if _ok:
		print("CSV 导入成功，生成 .tres 文件: ", INPUT_CSV_PATH)
	else:
		print("CSV 导入失败")	
	
func import_csv_to_starset_tres(csv_path: String, tres_path: String) -> bool:
	# 1) 读取文件文本
	var file_text = FileAccess.get_file_as_string(csv_path)
	# 如果文件不存在或读取失败, file_text 将是空字符串
	if file_text == "":
		push_error("无法读取 CSV 文件: " + csv_path)
		return false

	var lines = file_text.split("\n")

	# 2) 开始解析 CSV 行
	var starset:StarSet = StarSet.new()
	# 假设表头: 0-星曜名称,1-分类,2-星曜分类,3-吉凶,4-五行,5-阴阳,6-得分,7-描述
	for i in range(1, lines.size()):
		var line = lines[i].strip_edges()
		if line == "":
			continue  # 空行

		var cols = line.split(",")
		if cols.size() < 8:
			continue  # 数据列不足, 可以做容错或警告

		var star_data:StarData = StarData.new()
		star_data.score = Score.new()
		star_data.score.base_score = cols[3]########待完善，以稀有度代替先

		star_data.star_id = cols[0]
		star_data.star_name = cols[2]
		star_data.rarity = cols[3]
		star_data.score.base_score = cols[4]
		star_data.yin_yang = cols[5]
		star_data.wu_xing = cols[6]
		star_data.texture_path = cols[7]
		star_data.starinfo_packed_path = cols[8]

		star_data.description.append(cols[9])
		print(star_data.star_name,star_data.score.base_score)
		
		
		starset.starset_total.append(star_data)
	# 3) 将数据存入自定义 Resource （例如 StarsDatabase.gd）

	# 4) 保存为 .tres
	ResourceSaver.save(starset,"res://data/starset_base.tres")
	var err = ResourceSaver.save(starset, tres_path)
	if err == OK:
		print(starset.starset_total)
		print("成功将 CSV 数据导出到: ", tres_path)
		return true
	else:
		push_error("保存 .tres 失败: " + str(err))
		return false
