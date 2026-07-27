extends Control

@onready var high_score_start: Label = $buttons_container/high_score
@onready var level_score: Label = $buttons_container/level_score

# ----- start screen ------
func _on_start_btn_pressed() -> void:
	print("start pressed");
	GameManager.reset_game();
	get_tree().change_scene_to_file("res://scenes/game.tscn");

func _on_exit_btn_pressed() -> void:
	print("exit pressed");
	get_tree().quit();

# ----- game over screen ------
func _on_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn");
	
func _ready():
	high_score_start.text = "High Score: " + str(GameManager.high_score);
	level_score.text = "Score: " + str(GameManager.curr_level);
