extends PanelContainer

var star_data = {}

func _ready():
	#连接mouse_entered/mouse_exited(如果在Editor里没自动连的话)
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
