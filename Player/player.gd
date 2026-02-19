extends CharacterBody2D

@export var movement_component: MovementComponent
@export var input_component: InputComponent
@export var gravity_component: GravityComponent
@export var jump_component: AdvancedJumpComponent
@export var change_world_component: ChangeWorldComponent
@export var hitbox_component: HitboxComponent


func _physics_process(delta: float) -> void:
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	gravity_component.handle_gravity(self, delta)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	change_world_component.handle_change_world(self, hitbox_component, input_component.get_change_input())
	hitbox_component.handle_espinho_detection(self)
	
	move_and_slide()
