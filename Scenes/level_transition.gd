extends CanvasLayer

@export var transition_time: float = 0.6

@onready var t_circle_out: TransitionRect = $Control/TCircleOut
@onready var t_circle_in: TransitionRect = $Control/TCircleOut2

var scene_to_load: String
var tween: Tween

func change_scene_to(scene_path: String) -> void:
	if tween:
		tween.kill()
	
	scene_to_load = scene_path
	get_tree().paused = true
	
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(t_circle_out, "factor", 1.0, transition_time).connect("finished", _load_new_scene)
	tween.chain().tween_property(t_circle_in, "factor", 0.0, transition_time)

func _load_new_scene() -> void:
	get_tree().paused = false
	t_circle_out.factor = 0.0
	t_circle_in.factor = 1.0
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
