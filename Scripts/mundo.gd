extends Node2D

@export var changeable_component: ChangeableComponent

@export var is_visible: bool = true
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var background: TileMapLayer = $Background


func _ready() -> void:
	Global.change_world.connect(change)
	
	if not is_visible:
		modulate = changeable_component.invisible_color
		background.material.set_shader_parameter("integrity", 0.0)

func change():
	is_visible = !is_visible
	tile_map_layer.z_index = 1-tile_map_layer.z_index
	
	var change_speed = 1
	
	if is_visible:
		background.material.set_shader_parameter("integrity", 0.0)
		var shader_tween = get_tree().create_tween()
		shader_tween.tween_property(background.material, "shader_parameter/integrity", 1.0, change_speed)
		z_index = -2
	else:
		z_index = -3
		#var shader_tween = get_tree().create_tween()
		#shader_tween.tween_property(background.material, "shader_parameter/integrity", 0.0, change_speed)
		
	changeable_component.change(self, is_visible)
