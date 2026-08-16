extends Node

@export var max_health : int = 1
@export var damage : int = 1

signal healthChanged(currentHP : int, maxHP : int)

var health : int = max_health:
	set(value):
		health = value
		healthChanged.emit(health, max_health)
