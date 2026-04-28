extends PanelContainer
class_name PlantNode
@export var plant_index:int
@export var plant_data:PlantData
#生长阶段贴图（种子，幼苗，成熟期）
@export var seed_texture:Texture
@export var mid_texture:Texture
@export var mature_texture:Texture

@onready var panel_container: PanelContainer = $PanelContainer
@onready var TextureR: TextureRect = $Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update_texture():
	if plant_data.current_age <=3:
		TextureR.texture=seed_texture
	elif plant_data.current_age <=6:
		TextureR.texture=mid_texture
	else:
		TextureR.texture=mature_texture
	pass
