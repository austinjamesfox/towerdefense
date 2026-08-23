extends PathFollow2D
class_name Enemy
@export var speed : float = 0

@onready var stats = $Stats

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_enemy(delta)

func move_enemy(delta):
	progress_ratio += delta*speed 

func take_damage(damageAmount : int):
	stats.health -= damageAmount

func _on_stats_health_changed(currentHP: int, maxHP: int) -> void:
	if currentHP <= 0:
		queue_free()
