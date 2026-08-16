extends Node

signal player_health_modified(healthValue : int)

var playerHealth : int = 100:
	set(value):
		playerHealth = clampi(value, 0, 500)
		player_health_modified.emit(playerHealth)
		print(playerHealth)
		
	get:
		return playerHealth
		
func player_lose_health(healthLost : int):
	playerHealth -= healthLost
