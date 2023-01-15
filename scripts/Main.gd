extends Node

export(PackedScene) var asteroid_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

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
	var asteroid = asteroid_scene.instance()
	
	var asteroid_spawn_location = get_node("AsteroidPath/AsteroidSpawnLocation")
	asteroid_spawn_location.offset = randi()
	
	var direction = asteroid_spawn_location.rotation + PI / 2
	asteroid.position = asteroid_spawn_location.position
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)
