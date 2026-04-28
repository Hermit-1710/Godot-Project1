extends PanelContainer
class_name StarLabelNode
# or extends Control, 但 Button/TextureButton 自带 mouse_entered 方便

var star_data = {}
#var typing_tween:Tween


func set_star_with_typing(data: Dictionary,tween:Tween):
	star_data = data
	print('set star data success:',star_data)
	# 更新UI
	typing_one_by_one(star_data.星曜名称,0.10,tween)
	#$Label.text = star_data["星曜名称"]
	$Label.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT
	$Label.autowrap_mode=TextServer.AUTOWRAP_ARBITRARY
	$Label.custom_minimum_size= Vector2(20,0)

func set_star_without_typing(data: Dictionary):
	star_data = data
	print('set star data success:',star_data)
	# 更新UI
	#typing_one_by_one(star_data.星曜名称,0.10)
	$Label.text = star_data["星曜名称"]
	$Label.horizontal_alignment=HORIZONTAL_ALIGNMENT_RIGHT
	$Label.autowrap_mode=TextServer.AUTOWRAP_ARBITRARY
	$Label.custom_minimum_size= Vector2(20,0)
		
func _ready():
	#typing_tween = get_tree().create_tween()
	# 连接mouse_entered/mouse_exited(如果在Editor里没自动连的话)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	if mouse_entered.is_connected(_on_mouse_entered):
		print("mouse_entered connected")
	if mouse_exited.is_connected(_on_mouse_exited):
		print("mouse_exited connected")
	pass
	

#弹出星曜信息界面
func _on_mouse_entered():
	# 让浮窗出现
	print('mouse hover over  the star')
	var popup:StarInfoPopup = get_node("/root/StarInfoPopup")  # 假设你把 StarInfoPopup 做成 AutoLoad单例 或场景中唯一节点
	
	popup.set_star_info(star_data)
	popup.show_popup_at(get_global_mouse_position())

func _on_mouse_exited():
	var popup = get_node("/root/StarInfoPopup")
	popup.hide_popup()


	
#逐字出现
func append_character(character:String):
	$Label.text += character

func typing_one_by_one(content:String,word_delay:float,tween:Tween):
	#typing_tween = get_tree().create_tween()  
	$Label.text = ''
	for character in content:
		tween.tween_callback(append_character.bind(character)).set_delay(word_delay)
		
