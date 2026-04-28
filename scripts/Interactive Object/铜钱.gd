extends Sprite2D

@onready var collision_shape_2d: CollisionShape2D = $RigidBody2D/CollisionShape2D
@onready var area:Area2D = $Area2D
@onready var shadow: Sprite2D = $shadow
const DROP_COIN = preload("res://sound/drop_coin.wav")
const PICKUPCOIN = preload("res://sound/pickupcoin.wav")
@export var stack_offset_y := -8 # 当堆叠时，硬币向上偏移量
@export var stack_limit := 10    # 一个堆最多能叠多少枚硬币(仅演示用)
var is_dragged = false
var mouse_offset = Vector2.ZERO
var original_z_index = 0
var stack_coins = []  # 用来保存同一堆里的硬币引用（如果你想数据上管理）
func reset_position():
	collision_shape_2d
	pass

func _ready() -> void:
	# 监听 Area2D 的输入事件
	area.input_event.connect(_on_Area2D_input_event)
	add_to_group("Coins")
	# 也可以在此记录一下硬币原本的 z_index，用于恢复
	original_z_index = z_index

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# 当鼠标左键按下时，判断拾取
			is_dragged = true
			self.skew = 0.0
			AudioPlayer.audio_play(PICKUPCOIN)
			shadow.visible = true
			# 记录鼠标相对硬币的位置偏移
			mouse_offset = get_global_position() - get_global_mouse_position()
			
			# 让硬币置顶显示（防止被其他硬币遮挡）
			z_index = 9999
			
			# 如果需要可在这里设置拾起阴影或外发光等：
			# $Sprite2D.material = preload("res://PickUpEffect.tres")
		else:
			# 如果鼠标左键抬起，则放下硬币
			is_dragged = false
			shadow.offset = Vector2(10,10) + (global_position/get_viewport_rect().size) * Vector2(10,10)
			global_position = get_global_mouse_position() - mouse_offset +Vector2(15,15)
			AudioPlayer.audio_play(DROP_COIN)
			# 恢复硬币的视觉效果
			z_index = original_z_index
			# $Sprite2D.material = null  # 恢复默认材质

func _process(delta: float) -> void:
	if is_dragged:
		# 拖拽中，更新坐标
		global_position = get_global_mouse_position() + Vector2(0,-15)
		adjust_shadow()
		# 检查是否与其他硬币重叠
		_check_and_stack()

func _check_and_stack() -> void:
	# 遍历场景中所有 Coin (包括自己), 简易做法：
	# 一般更好的方式是将所有Coin注册到某个管理器中，以提高效率
	for other_coin in get_tree().get_nodes_in_group("Coins"):
		if other_coin == self:
			continue
		
		# 如果相交，就执行堆叠逻辑
		if area.get_overlapping_areas():
			if other_coin.area in area.get_overlapping_areas():
				_do_stack(other_coin)
				
				# 如果不想一次检测多个硬币，可以在第一次堆叠后直接 break
				# break
func adjust_shadow()->void:
	var ratio = global_position/get_viewport_rect().size
	shadow.offset = Vector2(10,10) + ratio * Vector2(30,30)
	print(shadow.offset)
func _do_stack(other_coin: Node2D) -> void:
	# 简易地将自己放到另一个硬币上方
	# 你可以自行设计更完善的堆叠规则
	# 比如把自己放在别人的 Sprite 上方，或者把二者一起放入新的 "StackRoot" 容器
	if len(other_coin.stack_coins) < stack_limit:
		global_position = other_coin.global_position + Vector2(0, stack_offset_y * (len(other_coin.stack_coins) + 1))
		# 调整Z坐标，使之在最顶
		z_index = other_coin.z_index + 1
		
		# 维护堆叠关系（只是示例用法）
		other_coin.stack_coins.append(self)
		
		# 若想两枚硬币以后都视为一堆，可把堆里的每一枚硬币都在同一个list里
		# 例如把 self.stack_coins = other_coin.stack_coins
		# 这样它们共享同一个列表
		
		# 也可触发音效 / 播放动画
		# $CoinStackSound.play()
