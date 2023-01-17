extends Area2D

@export var speed = 100.0

func _ready():
	connect("body_entered",Callable(self,"_on_body_entered"))
	
func _process(delta):
	var velocity = Vector2(0, -speed)
	position += velocity * delta
	
func _on_body_entered(body):
	pass
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
