extends Node
class_name MovementComponent

@export_group("Settings")
@export var speed: float = 100
@export var ground_accel_speed: float = 6.0
@export var ground_decel_speed: float = 8.0
@export var air_accel_speed: float = 6.0
@export var air_decel_speed: float = 8.0

func handle_horizontal_movement(body: CharacterBody2D, direction: float):
	var velocity_change_speed: float
	if body.is_on_floor():
		velocity_change_speed = ground_accel_speed if direction != 0.0 else ground_decel_speed
	else:
		velocity_change_speed = air_accel_speed if direction != 0.0 else air_decel_speed
		
	body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)

func handle_death_movement(body:CharacterBody2D):
	body.velocity = body.velocity.move_toward(Vector2.ZERO, air_decel_speed)

func apply_impulse_to_direction(body: CharacterBody2D, direction: Vector2):
	body.velocity = direction * speed

 
