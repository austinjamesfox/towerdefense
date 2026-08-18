extends Node2D

@export var enemyPath : Path2D

@export var enemy : PackedScene

@export var enemyOne : PackedScene

@export var gameManager : Node

var readyToSpawn : bool = false

@onready var rounds = {
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
	round_spawn()
	#var enemy = enemy_scene.instantiate()
	#enemyPath.add_child(enemy)
	#gameManager.player_lose_health(10)

# The current round variable should be managed in the GameManager instead. This is only temp.
@export var currentRound = 1

func round_spawn():
	for spawnGroup in rounds[currentRound]:
		for i in range(spawnGroup["quantity"]):
			var enemy = spawnGroup["enemy"].instantiate()
			enemyPath.add_child(enemy)
			createTimer(spawnGroup["spawn_rate"])
			
			
		
func createTimer(spawnRate):
	var spawnTimer = Timer.new()
	spawnTimer.wait_time = spawnRate
	spawnTimer.one_shot = true
	add_child(spawnTimer)
	spawnTimer.start()
	
