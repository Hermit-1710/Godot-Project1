extends VBoxContainer

###############
var tween: Tween

var score:int = 0:
	set(value):
		score = value
		_on_score_set(value)
var temp_score:int = 0 :
	set(val):
		temp_score = val
		score_ui.text = str(temp_score)

var multiple:int = 1:
	set(value):
		multiple = value
		_on_multiple_set(value)
var temp_multiple:int = 1 :
	set(val):
		temp_multiple = val
		multiple_ui.text = str(temp_multiple)
##############
@onready var multiple_ui: Label = $倍率
@onready var score_ui: Label = $分数
##############
##############
##############
#结算分数动效
func clear()-> void:
	score = 0
	multiple = 1
	
func _on_score_set(new_value: int)-> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self,"temp_score",score,1.0)
	await tween.finished
	return
func _on_multiple_set(new_value: int)-> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self,"temp_multiple",multiple,1.0)
	await tween.finished
	return
