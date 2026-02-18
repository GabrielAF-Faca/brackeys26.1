extends Node2D

func _ready() -> void:
	Global.change_world.connect(change)

func change():
	visible = !visible
