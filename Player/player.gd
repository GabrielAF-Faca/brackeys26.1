extends CharacterBody2D

@export var movement_component: MovementComponent
@export var input_component: InputComponent
@export var gravity_component: GravityComponent
@export var jump_component: AdvancedJumpComponent
@export var change_world_component: ChangeWorldComponent
@export var animation_component: AnimationComponent
@export var hitbox_component: HitboxComponent

@onready var gpu_particles_2d: ShockwaveEmitter = $GPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const DISAPPEAR = preload("uid://btfvo04mbfdhc")

var is_dead: bool = false


func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_dead:
		movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
		jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
		change_world_component.handle_change_world(self, hitbox_component, input_component.get_change_input())
		hitbox_component.handle_espinho_detection(self)
		animation_component.handle_move_animation(input_component.input_horizontal)
		animation_component.handle_jump_animation(jump_component.is_jumping, gravity_component.is_falling)
	else:
		movement_component.handle_death_movement(self)
	
	gravity_component.handle_gravity(self, delta)
	move_and_slide()


func die():
	animated_sprite_2d.material = DISAPPEAR
	animated_sprite_2d.material.set("shader_parameter/dissolve_rate", -1.4)
	is_dead = true
	var last_direction = velocity.normalized()
	var impulse_direction = Vector2(last_direction.x, 1.5 if gravity_component.is_falling else 0)
	
	var tween = get_tree().create_tween()
	tween.tween_property(gravity_component, "gravity", 0, 0.7).set_ease(Tween.EASE_OUT)
	tween.parallel()
	tween.tween_property(animated_sprite_2d.material, "shader_parameter/dissolve_rate", 1.0, 1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(Global.transition_level.bind("res://Scenes/main.tscn"))
	
	
	velocity = Vector2.ZERO
	movement_component.apply_impulse_to_direction(self, -impulse_direction)
	animation_component.handle_death_animation()
