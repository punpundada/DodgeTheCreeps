extends Node2D

@export var mob_scene: PackedScene;
#@export var hud_Scene:PackedScene;
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass
	#print("Game started")



func game_over() -> void:
	$ScoreTimer.stop();
	$MobTimer.stop()
	$HUD.show_game_over_screen();
	$Music.stop();
	$DeathSound.play();
	
func new_game()->void:
	score =0;
	$Player.start($StartPosition.position);
	$StartTimer.start();
	$HUD.update_score(score);
	get_tree().call_group('mob','queue_free')
	$Music.play();

func _on_score_timer_timeout() -> void:
	score += 1;
	$HUD.update_score(score);


func _on_start_timer_timeout() -> void:
	$MobTimer.start();
	$ScoreTimer.start();

func _on_mob_timer_timeout() -> void:
	#instanciate scene
	var mob = mob_scene.instantiate();
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/ModSpawnLocation;
	mob_spawn_location.progress_ratio = randf();
	
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Set the mob's direction perpendicular to the path direction.
	var tation = mob_spawn_location.rotation + PI / 2
	
	# Add some randomness to the direction.
	tation += randf_range(-PI / 4, PI / 4)
	mob.rotation = tation
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(tation)
	add_child(mob)
	
	
