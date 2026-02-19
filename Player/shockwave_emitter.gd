extends GPUParticles2D


func _ready() -> void:
	Global.change_world.connect(emit_shockwave)


func emit_shockwave():
	emitting = true


#func _process(delta: float) -> void:
	#if emitting:
		#print("bosta")
	#else:
		#print("merda")
