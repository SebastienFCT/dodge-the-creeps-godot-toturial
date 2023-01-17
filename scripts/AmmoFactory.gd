extends Node
	
func generate_ammo(type):
	return get_child(type).duplicate()
