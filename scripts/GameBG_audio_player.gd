extends AudioStreamPlayer
const BOSS站_切入_节奏电音PIXEL_WARS = preload("res://sound/embient/boss站-切入-节奏电音Pixel Wars.wav")
const BOSS站_紧张_魔性_电音_FRUIT_MACHINE_ = preload("res://sound/embient/boss站-紧张-魔性-电音-Fruit Machine-.wav")
const SHOP_图鉴_REST_TIME = preload("res://sound/embient/shop--Rest time.wav")
const 主界面_前几关_中式_不紧不慢_轻松活力LANTERN = preload("res://sound/embient/中式-不紧不慢-轻松活力Lantern.wav")
const 夜晚悠扬NIGHT_VIEW = preload("res://sound/embient/夜晚悠扬Night View.wav")
const 夜晚CIRCULATION_LOOP_ = preload("res://sound/embient/夜晚Circulation(loop).wav")
const 魔性_中场_短WAITING = preload("res://sound/embient/魔性-中场-短Waiting.wav")
const 可爱_小动物_节奏感CUTE_JUMP = preload("res://sound/embient/可爱-小动物-节奏感Cute Jump.wav")

@export_enum("Round","Shop","Pickup","BossFight","IllustratedGuide") var status:String = "Round"
@export var guide_open_button:GameButton
@export var round_open_button:GameButton
@export var shop_open_button:GameButton
@export var boss_open_button:GameButton
@export var pick_open_button:GameButton

func _ready() -> void:
	guide_open_button.pressed.connect(guide_bg_sound)
	round_open_button.pressed.connect(round_bg_sound)
	boss_open_button.pressed.connect(boss_bg_sound)
	shop_open_button.pressed.connect(shop_bg_sound)
	pick_open_button.pressed.connect(pick_bg_sound)
	boss_bg_sound()

func play_audio(audio:AudioStream) -> void:
	self.stream = audio
	self.play()

func shop_bg_sound() -> void:
	var bg_list=[SHOP_图鉴_REST_TIME,魔性_中场_短WAITING]
	var index = randi_range(0, len(bg_list)-1) 
	play_audio(bg_list[index])

func boss_bg_sound() -> void:
	var bg_list=[BOSS站_切入_节奏电音PIXEL_WARS,BOSS站_紧张_魔性_电音_FRUIT_MACHINE_]
	var index = randi_range(0, len(bg_list)-1) 
	play_audio(bg_list[index])

func pick_bg_sound() -> void:
	var bg_list=[夜晚悠扬NIGHT_VIEW ,夜晚CIRCULATION_LOOP_]
	var index = randi_range(0, len(bg_list)-1) 
	play_audio(bg_list[index])
func round_bg_sound() -> void:
	var bg_list=[可爱_小动物_节奏感CUTE_JUMP ,主界面_前几关_中式_不紧不慢_轻松活力LANTERN]
	var index = randi_range(0, len(bg_list)-1) 
	play_audio(bg_list[index])

func guide_bg_sound() -> void:
	var bg_list=[SHOP_图鉴_REST_TIME]
	var index = randi_range(0, len(bg_list)-1) 
	play_audio(bg_list[index])
