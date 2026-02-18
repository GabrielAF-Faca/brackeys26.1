extends Node2D

@export var changeable_component: ChangeableComponent

@export var is_visible: bool = true


func _ready() -> void:
	Global.change_world.connect(change)
	
	if not is_visible:
		modulate = changeable_component.invisible_color

func change():
	is_visible = !is_visible
	
	changeable_component.change(self, is_visible)
