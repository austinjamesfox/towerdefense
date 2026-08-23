extends Control

@onready var money_label: Label = %MoneyLabel
@onready var health_label: Label = %HealthLabel
@onready var round_label: Label = %RoundLabel

var currentRound : int = 1

signal playButtonPressedHUD(pressed)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_manager_player_health_modified(playerHealth : int) -> void:
	health_label.text = "Health: " + str(playerHealth)


func _on_play_button_pressed() -> void:
	playButtonPressedHUD.emit(true)


func _on_game_manager_next_round(nextRound: int) -> void:
	currentRound = nextRound
	round_label.text = "Round: " + str(currentRound)
