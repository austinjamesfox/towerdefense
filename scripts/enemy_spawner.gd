extends Node2D

@export var enemyPath : Path2D

@export var enemy : PackedScene

@export var enemyOne : PackedScene

@export var gameManager : Node

@export var enemyManager : Node

var roundActive : bool = false

signal enemiesSpawning(spawning : bool)

var currentlySpawning : bool = false:
	set(value):
		enemiesSpawning.emit(value)
	get:
		return currentlySpawning


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

# The current round variable should be managed in the GameManager instead. This is only temp.
@export var currentRound = 1

func round_spawn():
	currentlySpawning = true
	for spawnGroup in rounds[currentRound]:
		for i in range(spawnGroup["quantity"]):
			var enemy = spawnGroup["enemy"].instantiate()
			enemyPath.add_child(enemy)
			enemyManager.addEnemyActive(enemy)
			var spawnTimer = createTimer(spawnGroup["spawn_rate"])
			await spawnTimer.timeout
			spawnTimer.queue_free()
	currentlySpawning = false
	
func createTimer(spawnRate):
	var spawnTimer = Timer.new()
	spawnTimer.wait_time = spawnRate
	spawnTimer.one_shot = true
	add_child(spawnTimer)
	spawnTimer.start()
	return spawnTimer


func _on_game_manager_round_active(active : bool) -> void:
	roundActive = active


func _on_game_manager_start_round() -> void:
	if (!roundActive && !currentlySpawning):
		round_spawn()
	else:
		print("Round Active: " + str(roundActive) + "\nCurrently Spawning: " + str(currentlySpawning))


func _on_game_manager_next_round(nextRound: int) -> void:
	currentRound = nextRound
