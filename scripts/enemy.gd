extends PathFollow2D
@export var speed : float = 0

@onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_enemy(delta)

func move_enemy(delta):
	progress_ratio += delta*speed 
