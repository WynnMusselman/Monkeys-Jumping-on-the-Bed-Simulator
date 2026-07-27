extends Node

var curr_level = 1;
var monkey_amt: int = 4;
var high_score: int = 0;

var monkeys_clicked: int = monkey_amt;



func has_won():
	if(monkeys_clicked <= 0):
		curr_level += 1;
		monkey_amt += 1; #monkey amout based on level
		monkeys_clicked = monkey_amt;
		
		if(curr_level >= high_score):
			high_score = curr_level;
		
		#goes to next level
		get_tree().change_scene_to_file("res://scenes/game.tscn");
		
		
func _process(delta) -> void:
	has_won();
	
func reset_game() -> void:
	
	curr_level = 1;
	monkey_amt = 4;
	monkeys_clicked = monkey_amt;
