extends Node
class_name AnimationComponent

@export_category("Settings")
@export var sprite: AnimatedSprite2D

func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return
	
	sprite.flip_h = false if move_direction > 0 else true

func handle_move_animation(move_direction: float) -> void:
	
	if sprite.animation == "death": return
	
	handle_horizontal_flip(move_direction)
	if move_direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func handle_jump_animation(is_jumping: bool, is_falling: bool) -> void:
	if sprite.animation == "death": return
	
	if is_falling:
		sprite.play("fall")
		return
	
	if is_jumping:
		sprite.play("jump")
		return

func handle_death_animation():
	sprite.play("death")
