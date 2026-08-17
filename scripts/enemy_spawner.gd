extends Node2D

@export var enemyPath : Path2D

@export var enemy_scene : PackedScene

@export var enemyOne : PackedScene

@export var gameManager : Node

var rounds = {
	#Round: ["Enemy Order", "Quantity per Enemy Order", Spawn Rate]
	#"One": [10, 10],
	#"Two": ["1111",0.5]
	1: [
		{
			"enemy": enemyOne,
			"quantity": 10,
			"spawn_rate": 1.0
		},
		{
			"enemy": enemyOne,
			"quantity": 5,
			"spawn_rate": 0.5
		}
		]
}

func _on_timer_timeout() -> void:
	# Spawn Enemy
	var enemy = enemy_scene.instantiate()
	enemyPath.add_child(enemy)
	#gameManager.player_lose_health(10)
