extends Node

signal change_world


func transition_level(scene_to):
	LevelTransition.change_scene_to(scene_to)
