extends CharacterBody2D
class_name Coin

var is_dragged = false
var mouse_offset = Vector2.ZERO

@onready var shadow: Sprite2D = $shadow
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const DROP_COIN = preload("res://sound/drop_coin.wav")
const PICKUPCOIN = preload("res://sound/pickupcoin.wav")
func _ready() -> void:
	# 让此 CharacterBody2D 可以接收鼠标点击事件
	input_pickable = true
	# 或者在 Editor 的 "Node" 面板中勾选 "Input > Pickable"

# Godot 4.x 对 CollisionObject2D 提供了 input_event 信号或虚函数
# 你可以在编辑器里连接该节点的 "input_event" 信号，也可以直接 override _input_event
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# 鼠标左键按下：开始拖拽
			AudioPlayer.audio_play(PICKUPCOIN)
			is_dragged = true
			_drag_status()
			mouse_offset = global_position - get_global_mouse_position()
		else:
			# 鼠标左键松开：结束拖拽
			is_dragged = false
			AudioPlayer.audio_play(DROP_COIN)
			global_position += Vector2(0,20)
			self.scale = Vector2(0.4,0.4)
			shadow.offset = Vector2(10,10) + (global_position/get_viewport_rect().size) * Vector2(10,10)
func drop():
	is_dragged = false
	AudioPlayer.audio_play(DROP_COIN)
	pass
func _drag_status():
	self.skew = 0.0
	self.scale *=1.05
	#拖拽时弹起效果
	global_position += Vector2(0,-20)
	shadow.offset = Vector2(10,10) + (global_position/get_viewport_rect().size) * Vector2(30,30)
	pass

func _physics_process(delta: float) -> void:
	if is_dragged:
		# 计算目标位置（让硬币中心跟随鼠标，并减去最初点下时的偏移）
		var target_pos = get_global_mouse_position() 

		# 每帧计算本次移动向量
		var direction= (target_pos - global_position).normalized() 
		velocity = velocity.move_toward(direction * (target_pos - global_position).length()*5, 5000*delta)
		# 使用 move_and_collide() 来移动并检测碰撞
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 100)
			# 如果跟其它刚体或 CharacterBody2D 碰撞了
	move_and_slide()
func _do_stack(other_coin: Coin) -> void:
	# 在这里实现“堆叠”逻辑
	# 比如：将自己放在 other_coin 上方
	# 或者把两者添加到同一个 Container/父节点下
	#
	# 简易示例：把硬币放在另一枚硬币上方 8 像素处
	var offset_y := -8.0
	global_position = other_coin.global_position + Vector2(0, offset_y)

	# 如果想真正锁定两者，可修改其模式、或给它们设置 Joint2D 等
	# 也可以在这里写入你的堆叠数据结构
	# ... 
