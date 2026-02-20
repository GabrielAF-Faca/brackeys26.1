extends GPUParticles2D


func _ready() -> void:
	Global.change_world.connect(emit_shockwave)


func emit_shockwave():
	emitting = true
