extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_animation_type = $AnimatedSprite2D.sprite_frames.get_animation_names();
	#print(randi() % mob_animation_type.size());
	$AnimatedSprite2D.play(mob_animation_type[randi() % mob_animation_type.size()])

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free();
