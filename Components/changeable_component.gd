extends Node
class_name ChangeableComponent

@export_subgroup("Vanishing Settings")
@export var invisible_color: Color = Color(1.0, 1.0, 1.0, 0.1)
@export var visible_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var vanishing_time: float = 0.2


func change(target: Node2D, is_visible: bool) -> void:
	if is_visible:
		var tween = get_tree().create_tween()
		tween.tween_property(target, "modulate", visible_color, vanishing_time)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(target, "modulate", invisible_color, vanishing_time)
