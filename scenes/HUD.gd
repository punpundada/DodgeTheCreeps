extends CanvasLayer

signal start_game;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_message(text:String)->void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over_screen()->void:
	show_message("Game Over");
	
	#wait untill game over screen
	await  $MessageTimer.timeout;
	
	$Message.text = "Dodge the Creeps!";
	$Message.show();
	
	#wait for a one show timer to finish
	await  get_tree().create_timer(1.0).timeout;
	$StartButton.show();
	
func update_score(score:int)->void:
	$ScoreLabel.text = str(score);


func _on_start_button_pressed() -> void:
	$StartButton.hide();
	start_game.emit()
	$Message.hide();


func _on_message_timer_timeout() -> void:
	$Message.hide();
