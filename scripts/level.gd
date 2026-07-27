extends Label
@onready var level: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.text = "Level: " + str(GameManager.curr_level);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
