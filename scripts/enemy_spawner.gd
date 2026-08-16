extends Node2D

@export var enemyPath : Path2D

@export var enemy_scene : PackedScene

@export var gameManager : Node

func _on_timer_timeout() -> void:
	# Spawn Enemy
	var enemy = enemy_scene.instantiate()
	enemyPath.add_child(enemy)
	#gameManager.player_lose_health(10)
