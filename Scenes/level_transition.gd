extends CanvasLayer

@onready var t_circle_out: TransitionRect = $Control/TCircleOut
@onready var t_circle_out_2: TransitionRect = $Control/TCircleOut2

var scene_to_load: String
var tween: Tween

func change_scene_to(scene_path: String) -> void:
	if tween:
		tween.kill()
		

func _load_new_scene() -> void:
	pass
