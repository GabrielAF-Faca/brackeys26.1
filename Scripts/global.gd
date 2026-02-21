extends Node

signal change_world
signal shake_screen(intensity, time)

func transition_level(scene_to):
	LevelTransition.change_scene_to(scene_to)
