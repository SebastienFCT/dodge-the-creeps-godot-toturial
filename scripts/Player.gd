extends Area2D
signal hit

@export var ammo_factory_scene: PackedScene
var ammo_factory

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo_factory = ammo_factory_scene.instantiate()
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
		
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "boost"
	else:
		$AnimatedSprite2D.animation = "slow"


func _on_Player_body_entered(body):
	if (!body.is_in_group(Global.GAME_GROUPS.PLAYER_AMMO)):
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_BaseAmmoTimer_timeout():
	var ammo = ammo_factory.generate_ammo(Global.AMMO_TYPES.BASE)
	ammo.position = self.position
	ammo.add_to_group(Global.GAME_GROUPS.PLAYER_AMMO)
	get_parent().add_child(ammo)
