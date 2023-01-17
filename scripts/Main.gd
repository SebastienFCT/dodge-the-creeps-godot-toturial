extends Node

@export var asteroid_factory_scene: PackedScene

var asteroid_factory
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	asteroid_factory = asteroid_factory_scene.instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_factory.generate_random()
	#var asteroid = asteroid_factory.generate(0)
	
	var asteroid_spawn_location = get_node("AsteroidPath/AsteroidSpawnLocation")
	asteroid_spawn_location.progress = randi()
	asteroid.position = asteroid_spawn_location.position
	
	var velocity = Vector2(0, randf_range(75.0, 150.0))
	asteroid.linear_velocity = velocity
	
	var scaleRatio = randf_range(0.7, 1.5)
	var scale = Vector2(scaleRatio, scaleRatio)
	asteroid.scale = scale
	
	var rotation = randf_range(0, PI)
	asteroid.rotation = rotation
	
	asteroid.add_to_group(Global.GAME_GROUPS.ASTEROIDS)
	
	add_child(asteroid)
