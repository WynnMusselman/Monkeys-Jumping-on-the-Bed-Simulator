extends Node2D

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar

@onready var bonus_second_animation: AnimationPlayer = $"../bonus_second/AnimationPlayer"
@onready var bonus_second_label: Label = $"../bonus_second"


func _ready():
	
#	every three levels, an addition second is added to the timer
	var bonus_time = GameManager.curr_level / 3;
	
	timer.start(timer.wait_time + bonus_time);
	progress_bar.max_value = timer.wait_time;
	
	print("time: " + str(timer.wait_time));
	
	if(GameManager.curr_level % 3 == 0):
		bonus_second_label.visible = true;
		bonus_second_animation.play("fade_into");
		await bonus_second_animation.animation_finished;
		bonus_second_label.visible = false;
		
	

func _process(delta) -> void:
	#print(timer.time_left)
	progress_bar.value = timer.wait_time - timer.time_left
	
	#if you lost
	if(progress_bar.value >= progress_bar.max_value):		
		get_tree().change_scene_to_file("res://scenes/game_over_menu.tscn");
		
	
