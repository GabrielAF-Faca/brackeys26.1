extends CharacterBody2D

@export var movement_component: MovementComponent
@export var input_component: InputComponent

func _physics_process(delta: float) -> void:
	movement_component.handle_movement(self, input_component.input_horizontal)
	move_and_slide()
