extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var speed = 600;
var screen_size; 

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed('left'):
		velocity.x -= 1;
	if Input.is_action_pressed('right'):
		velocity.x += 1;
	if Input.is_action_pressed("up"):
		velocity.y -= 1;
	if Input.is_action_pressed('down'):
		velocity.y += 1;

	if velocity.length() > 0:
		velocity = velocity.normalized()*speed;
		animated_sprite_2d.play();
	else :
		animated_sprite_2d.stop()
#this is to restrict the player from leaving the screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		animated_sprite_2d.animation = "WALK"
		animated_sprite_2d.flip_v = false
	# See the note below about the following boolean assignment.
		animated_sprite_2d.flip_h = velocity.x < 0
	elif velocity.y != 0:
		animated_sprite_2d.animation = "UP"
		animated_sprite_2d.flip_v = velocity.y > 0


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred('disabled',true);
	
func start(pos):
	position = pos;
	show();
	$CollisionShape2D.disabled = false;
