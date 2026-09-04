extends Node

@export var enemyManager : Node
signal player_health_modified(healthValue : int)
signal round_lost
signal roundActive(active : bool)
signal nextRound(nextRound : int)

signal startRound

var currentlySpawning : bool = false

var playerHealth : int = 100:
	set(value):
		playerHealth = clampi(value, 0, 500)
		player_health_modified.emit(playerHealth)
		if playerHealth == 0:
			game_over()

	get:
		return playerHealth

var currentRound : int = 1:
	set(value):
		currentRound = value
		nextRound.emit(currentRound)
	get:
		return currentRound

func player_lose_health(healthLost : int):
	playerHealth -= healthLost

func game_over():
	round_lost.emit()
	print("Game Over!")
	Engine.time_scale = 0

func next_round(round):
	currentRound += round
	nextRound.emit(currentRound)

func _process(delta: float) -> void:
	print(enemyManager.activeEnemies )

func _on_hud_play_button_pressed_hud(pressed: Variant) -> void:
	if (!currentlySpawning && enemyManager.activeEnemies == 0):
		startRound.emit()
		roundActive.emit(true)


func _on_enemy_spawner_enemies_spawning(spawning: bool) -> void:
	currentlySpawning = spawning
	print("Spawning: " + str(spawning))


func _on_enemy_manager_all_enemies_dead(dead : bool) -> void:
	if (!currentlySpawning):
		roundActive.emit(false)
		next_round(1)
