class_name Monkey
extends Area2D

var speed: int = randf_range(50, 80); #each monkey gets its own random speed 
var direction: int = -1; #-1 = up, 1 = down, 0 = grabbed

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var start_height: float = position.y #initial staring position
@onready var max_height: float = start_height - 40;

var is_dragging : bool = false; #if the monkey is currently being dragged

#game timer
#@onready var progress_bar: ProgressBar = $GameManager/Timer/ProgressBar
func _ready() -> void:
	#only one monkey can be clicked at a time
	#only monkey on top layer will be clicked
	get_viewport().physics_object_picking_sort = true;
	get_viewport().physics_object_picking_first_only = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#	if moving up
	if direction == -1:
		animated_sprite.play("up");
		if(position.y <= max_height):
			direction = 1;
			
	#if moving down
	elif direction == 1:
		animated_sprite.play("down");
		if(position.y >= start_height):
			direction = -1;
			
	#monkey is being dragged and has no speed now
	elif direction == 0:
		animated_sprite.play("grab");
		
	#monkey is falling and is moving at twice the speed downward
	elif direction == 2:
		animated_sprite.play("thrown");
		speed = 50; #all monkeys have the same falling speed
		#when monkey goes off screen, it is deleted
		if(position.y >= 150):
			queue_free();
	
	#monkey follows mouse when clicked
	if(is_dragging == true):
		global_position = get_global_mouse_position();
		
		
	position.y += direction * speed * delta;

	
#NOTE - in godot, y increases as you move DOWN


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#monkey is dragged
	if(event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_LEFT):
		if(event.pressed):
			#if get_rect().has_point(to_local(get_global_mouse_position())):
			is_dragging = true;
			direction = 0;

		#monkey is released (thrown)
		else:
			is_dragging = false;
			direction = 2;
			collision_shape_2d.disabled = true;
			GameManager.monkeys_clicked -= 1;
			
			
	
