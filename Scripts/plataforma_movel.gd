extends Node2D

@onready var plataforma: AnimatableBody2D = $Plataforma
@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

@export var is_mundo_normal: bool = true
@export var is_visible: bool = true
@export var changeable_component: ChangeableComponent

@export var tween_time_go: float = 1.0
@export var tween_ease_go: Tween.EaseType = Tween.EASE_OUT
@export var tween_trans_go: Tween.TransitionType = Tween.TRANS_CUBIC

@export var tween_time_back: float = 1.0
@export var tween_ease_back: Tween.EaseType = Tween.EASE_OUT
@export var tween_trans_back: Tween.TransitionType = Tween.TRANS_CUBIC


func _ready() -> void:
	Global.change_world.connect(change)
	plataforma.position = path_2d.curve.get_point_position(0)
	
	if not is_mundo_normal:
		plataforma.set_collision_layer_value(5, false)
		plataforma.set_collision_layer_value(6, true)
		change()
		
	move_to_final()


func change():
	is_visible = !is_visible
	
	changeable_component.change(self, is_visible)


func move_to_final():
	path_follow_2d.progress_ratio = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(path_follow_2d, "progress_ratio", 0.99, tween_time_go).set_trans(tween_trans_go).set_ease(tween_ease_go)
	tween.tween_callback(move_to_start)

func move_to_start():
	path_follow_2d.progress_ratio = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(path_follow_2d, "progress_ratio", 0.01, tween_time_back).set_trans(tween_trans_back).set_ease(tween_ease_back)
	tween.tween_callback(move_to_final)

func _process(delta: float) -> void:
	plataforma.position = path_follow_2d.position
