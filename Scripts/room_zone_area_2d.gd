extends Area2D
class_name RoomZoneArea2D

@export var zoom: Vector2 = Vector2.ONE

@export var follow_player: bool = false
@export var fixed_position: Vector2 = Vector2.ZERO

@export var limit_camera: bool = false

@export var marker_top_left: Marker2D
@export var marker_bottom_right: Marker2D


var collisionshape: CollisionShape2D
var cam_node: RoomZoneCamera2D

func _ready() -> void:
	collisionshape = get_child(0)
	monitorable = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func get_top_left_limit() -> Vector2:
	return marker_top_left.global_position

func get_bottom_right_limit() -> Vector2:
	return marker_bottom_right.global_position

func _on_body_entered(body: Node2D) -> void:
	print("pau")
	print(body)
	if body.is_in_group("player"):
		if !cam_node:
			cam_node = get_tree().get_first_node_in_group("RoomZoneCamera")
		cam_node.overlapping_zones.append(self)

func _on_body_exited(body: Node2D) -> void:
	print("pinto")
	if body.is_in_group("player"):
		if !cam_node:
			cam_node = get_tree().get_first_node_in_group("RoomZoneCamera")
		cam_node.overlapping_zones.erase(self)
