extends HBoxContainer

@export var total_count:int = 5
@export var star_achieved:int =0

const STAR = preload("res://scene/图鉴/star.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _init():
	#清除原有所有子节点
	for i in self.get_children():
		i.queue_free()
	#添加total_count数量星星，黑色
	for i in range(total_count):
		var star:TextureRect=STAR.instantiate()
		if i in range(star_achieved):
			star.modulate=Color(1,1,1,1)
		else:
			star.modulate=Color(0,0,0,1)
		self.add_child(star)
		
		
func add_star_achieved():
	star_achieved+=1
	pass
func _illuminate(index):
	var star_to_illuminate : TextureRect= self.get_child(index)
	star_to_illuminate.modulate = Color.WHITE
	pass


func _on_button_pressed() -> void:
	add_star_achieved()
	_illuminate(star_achieved-1)
	pass # Replace with function body.
