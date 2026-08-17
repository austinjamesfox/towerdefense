extends Node

signal player_health_modified(healthValue : int)
signal round_lost

var playerHealth : int = 100:
	set(value):
		playerHealth = clampi(value, 0, 500)
		player_health_modified.emit(playerHealth)
		if playerHealth == 0:
			game_over()

	get:
		return playerHealth

func player_lose_health(healthLost : int):
	playerHealth -= healthLost

func game_over():
	round_lost.emit()
	print("Game Over!")
	Engine.time_scale = 0
