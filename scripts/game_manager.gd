extends Node

signal player_health_modified(healthValue : int)
signal round_lost
signal roundActive
signal nextRound(nextRound : int)

signal startRound

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
		print("initial current round is " + str(currentRound))
		currentRound = value
		nextRound.emit(currentRound)
		print("Set round to " + str(currentRound))
	get:
		print("Getter CurrentRound = "+ str(currentRound))
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

func _on_hud_play_button_pressed_hud(pressed: Variant) -> void:
	startRound.emit()
	roundActive.emit()
