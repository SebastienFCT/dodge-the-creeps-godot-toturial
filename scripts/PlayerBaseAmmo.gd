extends "res://scripts/Ammo.gd"

func _on_body_entered(body):
	if (body.is_in_group(Global.GAME_GROUPS.ASTEROIDS)):
		body.damage()
		queue_free()
