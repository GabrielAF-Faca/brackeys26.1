extends Area2D
class_name HitboxComponent



func handle_espinho_detection(body: CharacterBody2D):
	var overlapping_bodies = get_overlapping_bodies()
	for i in overlapping_bodies:
		if i != body:
			print(i)
			break
