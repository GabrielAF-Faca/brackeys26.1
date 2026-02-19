extends Node2D

@export var changeable_component: ChangeableComponent

@export var is_visible: bool = true
@onready var tile_map_layer: TileMapLayer = $TileMapLayer


func _ready() -> void:
	Global.change_world.connect(change)
	
	if not is_visible:
		modulate = changeable_component.invisible_color

func change():
	is_visible = !is_visible
	tile_map_layer.z_index = 1-tile_map_layer.z_index
	changeable_component.change(self, is_visible)
