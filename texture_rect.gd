extends TextureRect
@onready var shadow: TextureRect = $Shadow
var shadow_origin_position
@onready var panel_container: PanelContainer = $PanelContainer
var origin_position
var transitiontype = 10
var _is_shown_mode :bool = false:
	set(value):
		_is_shown_mode = value
		if value == true:
			set_process(true)
			set_process_input(true)
		else:
			set_process(false)
			set_process_input(false)
			self.get_material().set_shader_parameter('y_rot', 0)
			self.get_material().set_shader_parameter('x_rot', 0)
			self.get_material().set_shader_parameter('shine_progress',0.5)
			shadow.position=shadow_origin_position	

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	origin_position = panel_container.position
	self.pivot_offset = size*0.5
	shadow_origin_position = shadow.position

func _process(delta: float) -> void:
	if _is_shown_mode:
		var mouse_position = get_local_mouse_position()
		var center_position = self.size *0.5
		var ratio = mouse_position/center_position - Vector2(1,1)
		self.get_material().set_shader_parameter('y_rot', ratio[0]*10)
		self.get_material().set_shader_parameter('x_rot',-ratio[1]*30)
		var unit = Vector2(1,1)
		var progress = (mouse_position/self.size).cross(unit)
		print(ratio,(progress*sqrt(2)/2 + 0.5))
		self.get_material().set_shader_parameter('shine_progress',(-progress*sqrt(2)/2 + 0.5))
		shadow.position = -ratio*20
	pass

func _on_mouse_entered() -> void:
	_is_shown_mode = true 
	print("mouse enter",panel_container.position)
	var tween_star_panel = get_tree().create_tween()
	var move = origin_position  + Vector2(155,0)
	tween_star_panel.tween_property(panel_container,'position',move,0.4).set_trans(transitiontype).set_ease(Tween.EASE_OUT_IN)#2,5#7,10
func _on_mouse_exited() -> void:
	_is_shown_mode = false
	var tween_star_panel = get_tree().create_tween()
	var move = panel_container.position - Vector2(160,0)
	tween_star_panel.tween_property(panel_container,'position',origin_position,0.3).set_trans(transitiontype).set_ease(Tween.EASE_OUT_IN)		
func test_transitiontype():
	transitiontype +=1
	print("current transition type",transitiontype)
