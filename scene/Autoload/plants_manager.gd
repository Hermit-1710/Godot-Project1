extends Node
class_name PlantsManager
@export var plant_status_UI:plants_status_UI
@export var starpanel:StarPanel
const PLANT = preload("res://scene/Plant.tscn")
var plant:PlantNode
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_4_pressed() -> void:
	if not plant:
		plant = PLANT.instantiate()
	plant.plant_data.current_age=0
	plant.plant_data.current_growth=0
	plant_status_UI.UI_update(plant.plant_data.current_growth)
	starpanel.place_plants(plant)
func plants_status_update():
	pass


func _on_button_pressed() -> void:
	if plant:
		plant.plant_data.update_growth(0,0,0)
		plant.update_texture()
		plant_status_UI.UI_update(plant.plant_data.current_growth)
		starpanel.place_plants(plant)
	pass # Replace with function body.
