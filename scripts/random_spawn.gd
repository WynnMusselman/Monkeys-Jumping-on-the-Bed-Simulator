extends Node2D

#creates square that monkeys can be spawned in
@export var point_1: Vector2 = Vector2(45, 38);
@export var point_2: Vector2 = Vector2(230, 128);

@onready var monkey_blueprint: Resource = preload("uid://d2tcpd4pbh6d4");
@onready var fast_monkey_blueprint: Resource = preload("uid://cy2noo34l33ep");
@onready var baby_monkey_blueprint: Resource = preload("uid://bhuxtdlhs262i");


#returns random point where monkey will be spawned
func get_random_point_inside(p1: Vector2, p2: Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x, p2.x);
	var y_value: float = randf_range(p1.y, p2.y);

	var random_point: Vector2 = Vector2(x_value, y_value);
	
	return random_point;
	
func spawn_monkey():
	#builds the node
	var rand_monkey_num: int = randi_range(1, 10);
	var monkey_instance: Monkey;
	
	#if current level is 3 or less, only spawn normal monkeys
	if(GameManager.curr_level <= 3):
		monkey_instance = monkey_blueprint.instantiate();
	
	#if current level is between 4 and 7, spawn a few fast monkeys
	elif(GameManager.curr_level <= 7):
		if(rand_monkey_num <= 8): #8/10 chance of being normal monkey
			monkey_instance = monkey_blueprint.instantiate();
		else: #2/10 chance of being fast monkey
			monkey_instance = fast_monkey_blueprint.instantiate();
		
	#if current level is between 8 and 11, spawn a few baby monkeys and more fast monkeys
	elif(GameManager.curr_level <= 11):
		if(rand_monkey_num <= 6): #6/10 chance of being normal monkey
			monkey_instance = monkey_blueprint.instantiate();
		elif(rand_monkey_num <= 9): #3/10 chance of being fast monkey
			monkey_instance = fast_monkey_blueprint.instantiate();
		else: #1/10 chance of being baby
			monkey_instance = baby_monkey_blueprint.instantiate();
			
	#if current level is between 12 and 18, spawn mostly fast monkeys, some baby monkeys, and a few normal monkeys
	elif(GameManager.curr_level <= 18):
		if(rand_monkey_num <= 3): #3/10 chance of being normal monkey
			monkey_instance = monkey_blueprint.instantiate();
		elif(rand_monkey_num <= 8): #5/10 chance of being fast monkey
			monkey_instance = fast_monkey_blueprint.instantiate();
		else: #2/10 chance of being baby
			monkey_instance = baby_monkey_blueprint.instantiate();
	
	#if current level is greater than 18, spawn mostly fast monkeys and some baby monkeys. No normal monkeys
	else:
		if(rand_monkey_num <= 6): #6/10 chance of being normal monkey
			monkey_instance = fast_monkey_blueprint.instantiate();
		else: #4/10 chance of being baby
			monkey_instance = baby_monkey_blueprint.instantiate();
	

	var spawn_location: Vector2 = get_random_point_inside(point_1, point_2);
	monkey_instance.set_position(spawn_location);
	
	#add nodes to scene tree
	add_child(monkey_instance);
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#randomize();
	var num_monkeys = GameManager.monkey_amt;
	for i in num_monkeys:
		spawn_monkey();
