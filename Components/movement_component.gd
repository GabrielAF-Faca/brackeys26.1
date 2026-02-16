extends Node
class_name MovementComponent

@export_group("Settings")
@export var speed: float = 100
@export var accel_speed: float = 6.0
@export var decel_speed: float = 8.0

func handle_movement(body: CharacterBody2D, direction: float):
	
	var velocity_change_speed: float = accel_speed if direction != 0.0 else decel_speed
	body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)
 
