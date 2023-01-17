extends Node

func generate(index):
	return get_child(index).duplicate()

func generate_random():
	return get_child(randi() % get_child_count()).duplicate()
