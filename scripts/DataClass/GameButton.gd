extends Button

class_name GameButton

func _ready() -> void:
	self.pressed.connect(button_click)
	
func button_click() -> void:
	AudioPlayer.button_click()
