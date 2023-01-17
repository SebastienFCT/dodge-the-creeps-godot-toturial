extends RigidBody2D

@export var health = 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	if health <= 0:
		queue_free()

func damage(value = 1):
	health -= value

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
