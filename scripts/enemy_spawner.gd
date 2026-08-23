extends Node2D

@export var enemyPath : Path2D

@export var enemy : PackedScene

@export var enemyOne : PackedScene

@export var gameManager : Node

var spawningEnemies : bool = false

var roundActive : bool = false

@onready var rounds = {
	1: [
		{
			"enemy": enemyOne,
			"quantity": 10,
			"spawn_rate": 1.0
		},
		{
			"enemy": enemyOne,
			"quantity": 25,
			"spawn_rate": 0.25
		}
		],
	2: [
		{
			"enemy": enemyOne,
			"quantity": 50,
			"spawn_rate": 0.1
		},
		{
			"enemy": enemyOne,
			"quantity": 25,
			"spawn_rate": 0.25
		}
		]
}

#func _on_timer_timeout() -> void:
	# Spawn Enemy
	#round_spawn()
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
			var spawnTimer = createTimer(spawnGroup["spawn_rate"])
			await spawnTimer.timeout
			spawnTimer.queue_free()
	roundActive = false
	print(currentRound)
	gameManager.next_round(1)
	
func createTimer(spawnRate):
	var spawnTimer = Timer.new()
	spawnTimer.wait_time = spawnRate
	spawnTimer.one_shot = true
	add_child(spawnTimer)
	spawnTimer.start()
	return spawnTimer
	


func _on_game_manager_round_active() -> void:
	roundActive = true


func _on_game_manager_start_round() -> void:
	if !roundActive:
		round_spawn()


func _on_game_manager_next_round(nextRound: int) -> void:
	currentRound = nextRound
