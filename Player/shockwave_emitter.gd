extends Node2D
class_name ShockwaveEmitter

@export var particles: Array[GPUParticles2D]

var next_to_emit = 0

func _ready() -> void:
	Global.change_world.connect(emit_shockwave)

func emit_shockwave():
	particles[0].restart()
	particles[0].emitting = true
	next_to_emit = 1 - next_to_emit
	
	
