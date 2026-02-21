extends Camera2D
class_name RoomZoneCamera2D

var overlapping_zones: Array = []
var active_zone: Area2D

@export_category("Settings")
@export var player_node: CharacterBody2D

#@export_category("Screen Shake")
var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise = FastNoiseLite.new()

var follow_player: bool = false


func _ready() -> void:
	add_to_group("RoomZoneCamera")
	Global.shake_screen.connect(screen_shake)

func _physics_process(delta: float) -> void:
	if follow_player and player_node:
		global_position = player_node.global_position
	
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5*delta)

func screen_shake(intensity: int, time: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0


func _process(_delta: float) -> void:
	
	if overlapping_zones.is_empty() or (overlapping_zones.size() == 1 and active_zone == overlapping_zones[0]):
		return
	
	var new_zone = get_closest_zone()
	if new_zone != active_zone:
		active_zone = new_zone
		apply_zone_settings()
	

func get_closest_zone() -> Area2D:
	var closest_zone: Area2D = null
	var closest_dist: float = INF
	var player_pos: Vector2 = player_node.global_position
	
	for zone in overlapping_zones:
		var zone_shape: CollisionShape2D = zone.collisionshape
		var col_margin: float = 0.1
		var zone_shape_pos: Vector2 = zone_shape.global_position
		var zone_shape_extents: Vector2 = zone_shape.shape.extents
		var shape_sides: Array[Vector2] = [
			Vector2(zone_shape_pos.x - zone_shape_extents.x + col_margin, player_pos.y),
			Vector2(zone_shape_pos.x + zone_shape_extents.x - col_margin, player_pos.y),
			Vector2(player_pos.x, zone_shape_pos.y - zone_shape_extents.y + col_margin),
			Vector2(player_pos.x, zone_shape_pos.y + zone_shape_extents.y - col_margin),
		]
		
		var closest_dist_shapeside := INF
		
		for col_side in shape_sides:
			var col_dist: float = player_pos.distance_to(col_side)
			if col_dist < closest_dist_shapeside:
				closest_dist_shapeside = col_dist
		
		if closest_dist_shapeside < closest_dist:
			closest_dist = closest_dist_shapeside
			closest_zone = zone
	
	return closest_zone

func apply_zone_settings():
	zoom = active_zone.zoom
	
	follow_player = active_zone.follow_player
	if !active_zone.follow_player:
		global_position = active_zone.fixed_position
	
	if active_zone.limit_camera:
		limit_enabled = true
		
		var top_left_limit = active_zone.get_top_left_limit()
		var bottom_right_limit = active_zone.get_bottom_right_limit()
		limit_left = top_left_limit.x
		limit_top = top_left_limit.y
		limit_right = bottom_right_limit.x
		limit_bottom = bottom_right_limit.y
	else:
		limit_enabled = false
