extends Node
class_name ChangeWorldComponent

@export var cooldown_timer: Timer

func handle_change_world(body: CharacterBody2D, wants_to_change_world: bool):
	
	if wants_to_change_world and cooldown_timer.is_stopped():
		cooldown_timer.start()
		body.set_collision_mask_value(5, !body.get_collision_mask_value(5))
		body.set_collision_mask_value(6, !body.get_collision_mask_value(6))
		Global.change_world.emit()
